class Post < ApplicationRecord
  belongs_to :user
  belongs_to :spin
  acts_as_votable

  def updatable_by?(current_user)
    current_user.id == user_id
  end

  def votable_by?(user)
    user.id == user_id
  end
end
