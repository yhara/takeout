class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.string :key
      t.string :log
      t.string :diff
      t.string :status
      t.datetime :commited_at

      t.timestamps
    end
  end
end
