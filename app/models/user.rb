class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :identities, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :retrospects, dependent: :destroy
  has_many :spins, dependent: :destroy

  acts_as_voter
end
