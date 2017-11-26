class Post < ApplicationRecord
  belongs_to :user
  belongs_to :spin
  acts_as_votable
end
