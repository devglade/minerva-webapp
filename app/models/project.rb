class Project < ApplicationRecord
  belongs_to :user
  belongs_to :space
  has_many :spins, -> {order('created_at desc').includes(:user)}, dependent: :destroy
  scope :by_created_at, -> {order(created_at: :DESC)}

  def updatable_by?(current_user)
    current_user.id == user_id
  end
end
