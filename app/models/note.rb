class Note < ActiveRecord::Base
  belongs_to :commit
  attr_accessible :body

  validates_presence_of :commit_id

  def set_name(name)
    return unless name
    self.body.chomp!
    self.body += "\n\n-- #{name}"
  end
end
