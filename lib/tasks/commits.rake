namespace :commits do
  desc "Fetch new commits (if any)"
  task :update => :environment do
    repos = Repository::SvnRepos.new(Takeout::Conf.repos_dir)
    repos.fetch_commits.each do |commit|
      p commit.save!
    end
  end

  task :reget => :environment do
    repos = Repository::SvnRepos.new(Takeout::Conf.repos_dir)
    Commit.order("key DESC").each do |c|
      Commit.transaction do
        c.destroy
        p repos.fetch_commit(c.key.to_i).save!
      end
    end
  end
end
