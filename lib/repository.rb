class Repository
  MAX_FETCH = 20

  def initialize(dir)
    @dir = dir
  end

  def command(_cmd)
    return Dir.chdir(@dir) do
      cmd = "#{_cmd} 2>&1"
      Rails.logger.info "- executing command: #{cmd.inspect}"
      ret = `#{cmd}`
      Rails.logger.debug "- result: " + ret.inspect
      ret
    end
  end

  class SvnRepos < Repository
    # Retuns an array of Commit (old one first)
    def fetch_commits
      last_rev = Commit.order("key DESC").first.try(:key).try(:to_i) || 0
      next_rev = last_rev + 1
      command "svn up"
      latest_rev = command("svn info")[/Revision: (\d+)/, 1].to_i

      revs = (next_rev..latest_rev).to_a.last(MAX_FETCH)
      return revs.map{|rev|
        fetch_commit(rev)
      }
    end

    def fetch_commit(key)
      rev = key.to_i
      diff = svn_diff(rev)
      log = svn_log(rev)
      message = log.lines.to_a[3..-3].join
      commited_at = DateTime.parse(log.lines.to_a[1].split(/\|/)[2])

      return Commit.new(key: rev.to_s,
                        log: message,
                        diff: diff,
                        commited_at: commited_at)
    end

    private
    def svn_log(rev)
      command("svn log -r #{rev}") #.lines.to_a[3..-3].join
    end

    def svn_diff(rev)
      if rev == 1
        "[Sorry, Takeout cannot show diff of r1]"
      else
        command("svn diff -r #{rev-1}:#{rev}")
      end
    end
  end

  class GitRepos < Repository
    def fetch_commits(last_key)
      "git fetch master"
    end
  end
end


