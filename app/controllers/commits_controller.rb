class CommitsController < ApplicationController
  def index
    @default_status = Takeout::Conf[:status_default]
    case params[:view]
    when "new"
      @commits = intersperse_date(Commit.recent.where(status: @default_status))
    when "updated"
      @commits = Commit.recent_commented
    else
      @commits = intersperse_date(Commit.recent)
    end

    if (name = cookies[:author_name])
      @mentions = Commit.where("status LIKE ?", "@#{name}%").all
    end
  end

  def show
    @commit = Commit.find(params[:id])
    @notes = @commit.notes.order("created_at")
    @note = Note.new

    @name = cookies[:author_name]
  end

  private
  def intersperse_date(commits)
    commits.chunk{|c| c.commited_at.to_date}
           .flat_map{|date, commits|
             [date] + commits
           }
  end
end
