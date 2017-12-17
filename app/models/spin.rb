class Spin < ApplicationRecord
  has_many :posts, dependent: :destroy

  belongs_to :user
  belongs_to :retrospect
  scope :opened, -> { where(status: 'opened') }
  scope :by_created_at, -> { order(created_at: :DESC) }

  enum status: {
      closed: 0,
      opened: 1,
  }
end
