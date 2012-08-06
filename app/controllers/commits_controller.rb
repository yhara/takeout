class CommitsController < ApplicationController
  def index
    @commits = Commit.order("created_at DESC")
  end

  def show
    @commit = Commit.find(params[:id])
    @notes = @commit.notes.order("created_at")
    @note = Note.new
  end
end
