class Spin < ApplicationRecord
  has_many :posts, dependent: :destroy
  enum status: {
      closed: 0,
      opened: 1,
  }
end
