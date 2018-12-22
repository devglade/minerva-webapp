class Invitation < ApplicationRecord
  belongs_to :space
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
end
