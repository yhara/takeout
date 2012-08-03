class CommitsController < ApplicationController
  # GET /commits
  # GET /commits.json
  def index
    @commits = Commit.order("created_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @commits }
    end
  end

  # GET /commits/1
  # GET /commits/1.json
  def show
    @commit = Commit.find(params[:id])
    @notes = @commit.notes.order("created_at")
    @note = Note.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @commit }
    end
  end
end
