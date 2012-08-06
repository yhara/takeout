class NotesController < ApplicationController
  def create
    @commit = Commit.find(params[:commit_id])
    @note = Note.new(params[:note])
    @note.commit = @commit

    respond_to do |format|
      if @note.save
        @commit.update_status!(@note.body)

        redirect_to @commit, notice: 'Note was successfully created.'
      else
        render action: "new"
      end
    end
  end
end
