class SpaceMember < ApplicationRecord

  belongs_to :user
  belongs_to :space

  scope :joined, ->(user_id) {where(user_id: user_id).order('created_at DESC')}

  def self.exist_member(recipient, space_id)
    if recipient == nil
      false
    else
      where(user_id: recipient.id, space_id: space_id).exists?
    end
  end
end
