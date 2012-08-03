require 'repository'

namespace :commits do
  desc "Fetch new commits (if any)"
  task :update => :environment do
    repos = Repository::SvnRepos.new(Takeout::Conf[:repos_url])
    repos.fetch_commits do |commit|
      commit.save!
      p commit
    end
  end

  task :reget => :environment do
    repos = Repository::SvnRepos.new(Takeout::Conf[:repos_url])
    Commit.order("created_at DESC").each do |commit|
      Commit.transaction do
        newc = repos.fetch_commit(commit.key).attributes
        %w(log diff commited_at author).each do |k|
          commit.send("#{k}=", newc[k])
        end
        commit.save!
        p commit
      end
    end
  end
end
