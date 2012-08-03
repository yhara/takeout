class ChangeDiffToText < ActiveRecord::Migration
  def up
    change_column :commits, :log, :text, limit: 1024
    change_column :commits, :diff, :text, limit: 65535
  end

  def down
    change_column :commits, :log, :string
    change_column :commits, :diff, :string
  end
end
