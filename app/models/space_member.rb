class SpaceMember < ApplicationRecord

  belongs_to :user
  belongs_to :space

  scope :joined, ->(user_id) {where(user_id: user_id).order('created_at DESC')}
  scope :except_mine, ->(ids) {where(id: ids).order('created_at DESC')}
  scope :is_member, ->(space_id, user_id) {where(space_id: space_id).where(user_id: user_id)}

  def self.exist_member(recipient, space_id)
    if recipient == nil
      false
    else
      where(user_id: recipient.id, space_id: space_id).exists?
    end
  end

  def self.join_if_needed current_user, token
    invitation = Invitation.find_by_token(token)
    if SpaceMember.exists?(user_id: invitation.recipient_id, space_id: invitation.space_id)
      message = "이미 가입되어있습니다."
    else
      space_id = invitation.space_id
      space_member = SpaceMember.new
      space_member.space_id = space_id
      space_member.user = current_user
      space_member.save
      message = "#{Space.find(space_id).name}공간에 가입되었습니다."
    end
    message
  end
end
