class Like < ActiveRecord::Base

  belongs_to :prototype
  belongs_to :user

  validates :user_id, presence: true
  validates :prototype_id, presence: true
end
