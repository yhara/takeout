class NotesController < ApplicationController
  def create
    @commit = Commit.find(params[:commit_id])
    @note = Note.new(params[:note])
    @note.commit = @commit
    if (name = params[:name])
      @note.set_name(name)
      cookies[:author_name] = {value: name, expires: 1.year.from_now}
    end

    if @note.save
      @commit.update_status!(@note.body, name)

      redirect_to commits_path, notice: 'Note was successfully created.'
    else
      redirect_to @commit
    end
  end
end
