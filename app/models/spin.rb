class Spin < ApplicationRecord
  has_many :posts, dependent: :destroy

  belongs_to :user
  belongs_to :retrospect

  enum status: {
      closed: 0,
      opened: 1,
  }
end
