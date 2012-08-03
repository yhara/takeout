class RemoveSlugFromCommit < ActiveRecord::Migration
  def up
    remove_column :commits, :slug
  end

  def down
    add_column :commits, :slug, :string
  end
end
