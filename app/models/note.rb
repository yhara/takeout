class Note < ActiveRecord::Base
  belongs_to :commit
  attr_accessible :body

  validates_presence_of :commit_id
end
