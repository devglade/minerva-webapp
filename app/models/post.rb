class Post < ApplicationRecord
  belongs_to :user
  belongs_to :spin
  belongs_to :section
  acts_as_votable

  def updatable_by?(current_user)
    current_user.id == user_id
  end

  def votable_by?(current_user)
    current_user.id != user_id
  end
end
