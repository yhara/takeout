class Note < ActiveRecord::Base
  attr_accessible :body, :commit_id, :user_id
end
