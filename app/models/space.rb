class Space < ApplicationRecord
  belongs_to :user
  has_many :projects

  def updatable_by?(current_user)
    current_user.id == user_id
  end
end
