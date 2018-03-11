class Spin < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :posts, dependent: :destroy
  has_many :sections, dependent: :destroy
  scope :opened, -> {where(status: 'opened')}
  scope :by_created_at, -> {order(created_at: :DESC)}

  enum status: {
      closed: 0,
      opened: 1,
  }
end
