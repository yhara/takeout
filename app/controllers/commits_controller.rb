class CommitsController < ApplicationController
  def index
    @commits = Commit.order("created_at DESC")
      .chunk{|c| c.commited_at.to_date}
      .flat_map{|date, commits|
        commits + [nil]
      }
  end

  def show
    @commit = Commit.find(params[:id])
    @notes = @commit.notes.order("created_at")
    @note = Note.new
  end
end
