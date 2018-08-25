class Post < ApplicationRecord
  acts_as_list scope: :section
  acts_as_votable

  belongs_to :user
  belongs_to :spin
  belongs_to :section

  def updatable_by?(current_user)
    current_user.id == user_id
  end

  def votable_by?(current_user)
    current_user.id != user_id
  end

  validates :content, presence: true

end
