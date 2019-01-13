class SpaceMember < ApplicationRecord

  belongs_to :user
  belongs_to :space

  scope :joined, ->(user_id) {where(user_id: user_id).order('created_at DESC')}
end
