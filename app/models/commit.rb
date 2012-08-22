class Commit < ActiveRecord::Base
  extend FriendlyId
  friendly_id :key

  has_many :notes
  attr_accessible :commited_at, :diff, :key, :log, :status, :author

  validates :key, uniqueness: true

  before_save :set_default_status

  scope :recent, order("created_at DESC")
  scope :recent_commented,
        select("DISTINCT commits.id, commits.*")
        .joins("LEFT OUTER JOIN notes ON commits.id = notes.commit_id")
        .order("max(notes.created_at) desc", "commits.key desc")

  def update_status!(note_body, name=nil)
    if (newstat = extract_status(note_body))
      if name
        self.status = "#{newstat} (#{name})"
      else
        self.status = newstat
      end

      self.save!
    end
  end

  private
  def set_default_status
    self.status ||= Takeout::Conf[:status_default]
  end

  def extract_status(body)
    first_line = body.lines.first
    return first_line[/^#(.+)|/, 1] || first_line[/^(@\S+)/, 1]
  end
end
