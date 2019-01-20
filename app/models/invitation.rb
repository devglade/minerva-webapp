class Invitation < ApplicationRecord
  belongs_to :space
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User', optional: true

  before_create :generate_token

  def generate_token
    self.token = Digest::SHA1.hexdigest([self.space_id, Time.now, rand].join)
  end

  # TODO 일단은 controller 에서 path를 받아옴. (나중에 settings에서 가져오도록 수정예정)
  def new_user_invite_link path
    "#{path}?invite_space_token=#{self.token}"
  end

  # TODO
  def exist_user_invite_link path
    "#{path}?invite_space_token=#{self.token}"
  end

  def self.is_invited_member current_user, token
    invitation = self.find_by_token token
    if current_user.id == invitation.recipient_id
      true
    else
      false
    end
  end

end
