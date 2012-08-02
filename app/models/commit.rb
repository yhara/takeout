class Commit < ActiveRecord::Base
  has_many :notes
  attr_accessible :commited_at, :diff, :key, :log, :status

  validates :key, uniqueness: true

  def update_status!(note_body)
    if (newstat = note_body.lines.first[/^#(.*)/, 1])
      self.status = newstat
      self.save!
    end
  end
end
