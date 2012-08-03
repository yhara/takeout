class NotesController < ApplicationController
  # POST /notes
  # POST /notes.json
  def create
    @commit = Commit.find(params[:commit_id])
    @note = Note.new(params[:note])
    @note.commit = @commit

    respond_to do |format|
      if @note.save
        @commit.update_status!(@note.body)

        format.html { redirect_to @commit, notice: 'Note was successfully created.' }
        format.json { render json: @commit, status: :created, location: @commit }
      else
        format.html { render action: "new" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end
end
