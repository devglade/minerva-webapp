class Section < ApplicationRecord
  acts_as_list

  belongs_to :spin

  has_many :posts, -> {order(position: :asc)}, dependent: :destroy

  scope :sorted, -> {order(position: :asc)}

  validates :title, presence: true
end
