class Commit < ActiveRecord::Base
  has_many :notes
  attr_accessible :commited_at, :diff, :key, :log, :status

  validates :key, uniqueness: true
end
