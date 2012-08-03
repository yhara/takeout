class AddSlugToCommit < ActiveRecord::Migration
  def change
    add_column :commits, :slug, :string
    add_index :commits, :slug, unique: true
  end
end
