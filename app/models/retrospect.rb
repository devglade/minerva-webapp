class Retrospect < ApplicationRecord
  belongs_to :user
  has_many :spins, -> {order('created_at desc').includes(:user)}, dependent: :destroy

  def updatable_by?(current_user)
    current_user.id == user_id
  end
end
