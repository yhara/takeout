class Repository
  MAX_FETCH = 20

  # Execute block with exclusive lock.
  # Return false if already locked. 
  def self.lock(&block)
    @lock_file ||= File.open("#{Rails.root}/tmp/repos.lock", "w")

    if @lock_file.flock(File::LOCK_EX | File::LOCK_NB)
      begin
        block.call
      ensure
        @lock_file.flock(File::LOCK_UN)
      end
      return true
    else
      return false
    end
  end

  def initialize(url)
    @url = url
  end

  def command(_cmd)
    cmd = "#{_cmd} 2>&1"
    Rails.logger.info "- executing command: #{cmd.inspect}"
    ret = `#{cmd}`
    Rails.logger.debug "  result: " + ret.truncate(1000).inspect
    ret
  end

  class SvnRepos < Repository
    # Return false if failed to get lock (i.e. someone's already
    # fetching commits elsewhere)
    def fetch_commits(&block)
      Repository.lock{
        next_rev = if (last_commit = Commit.order("created_at DESC").first)
                     last_commit.key[/\d+/].to_i + 1
                   else
                     1
                   end
        Rails.logger.info "Next revision: #{next_rev}"

        revs = (next_rev..get_latest_rev).to_a.last(MAX_FETCH)
        revs.each do |rev|
          if (commit = fetch_commit("r#{rev}"))
            yield commit
          end
        end
      }
    end

    def fetch_commit(key)
      rev = key[/\d+/].to_i
      diff = get_svn_diff(rev)
      if diff.empty?
        Rails.logger.info "Got empty diff for #{key}. Skipping"
        return nil
      end
      log = get_svn_log(rev)
      message = log.lines.to_a[3..-2].join.strip
      author = log.lines.to_a[1].split(/\|/)[1].strip
      commited_at = DateTime.parse(log.lines.to_a[1].split(/\|/)[2])

      return Commit.new(key: "r#{rev}",
                        log: message,
                        diff: diff,
                        author: author,
                        commited_at: commited_at)
    end

    private

    def get_latest_rev
      rev_s = command("svn info #{@url}")[/Revision: (\d+)/, 1]
      if rev_s
        rev_s.to_i
      else
        raise "Failed to get latest revision from svn info"
      end
    end

    def get_svn_log(rev)
      command("svn log -r #{rev} #{@url}")
    end

    def get_svn_diff(rev)
      if rev == 1
        "[Sorry, Takeout cannot show diff of r1]"
      else
        command("svn diff -r #{rev-1}:#{rev} #{@url}").truncate(Takeout::Conf[:max_diff_size])
      end
    end
  end

  class GitRepos < Repository
    def fetch_commits(last_key)
      "git fetch master"
    end
  end
end


