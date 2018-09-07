class Space < ApplicationRecord
  belongs_to :user
  has_many :projects

  scope :mine, ->(user_id) {where(user_id: user_id).order('created_at DESC')}

  def updatable_by?(current_user)
    current_user.id == user_id
  end
end
