class AddAuthorToCommits < ActiveRecord::Migration
  def change
    add_column :commits, :author, :string
  end
end
