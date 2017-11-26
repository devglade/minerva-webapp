class Retrospect < ApplicationRecord
  belongs_to :user

  has_many :spins, dependent: :destroy
end
