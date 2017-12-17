class Retrospect < ApplicationRecord
  belongs_to :user
  has_many :spins, -> {order('created_at desc').includes(:user)}, dependent: :destroy
end
