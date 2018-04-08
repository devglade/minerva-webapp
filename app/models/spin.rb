class Spin < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :posts, -> {order(created_at: :DESC)}, dependent: :destroy
  has_many :sections, dependent: :destroy
  scope :opened, -> {where(status: 'opened')}
  scope :by_created_at, -> {order(created_at: :DESC)}

  enum status: {
      closed: 0,
      opened: 1,
  }

  after_create do |spin|
    Section.create(title: "좋았던 점", order: 0, spin_id: spin.id)
    Section.create(title: "안좋았던 점", order: 1, spin_id: spin.id)
  end

end
