class Like < ActiveRecord::Base
  validates :user_id, presence: true
  validates :prototype_id, presence: true
end
