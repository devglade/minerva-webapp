class SpaceMember < ApplicationRecord

  has_many :spaces
  has_many :user

end
