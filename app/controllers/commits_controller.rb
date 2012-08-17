class CommitsController < ApplicationController
  def index
    @default_status = Takeout::Conf[:status_default]
    if params[:view] == "new"
      commits = Commit.order("created_at DESC")
                      .where(status: @default_status)
    else
      commits = Commit.order("created_at DESC")
    end

    @commits = commits
      .chunk{|c| c.commited_at.to_date}
      .flat_map{|date, commits|
        [date] + commits
      }

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
end
