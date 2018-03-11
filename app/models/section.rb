class Section < ApplicationRecord
  belongs_to :spin
  has_many :posts
end
