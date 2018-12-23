class SpaceMember < ApplicationRecord

  has_many :user
  has_many :spaces

end
