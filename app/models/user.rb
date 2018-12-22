class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :identities, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :spins, dependent: :destroy
  has_many :spaces, through: :space_members
  has_many :invitations, foreign_key: 'recipient_id'
  has_many :sent_invitations, class_name: 'Invitation', foreign_key: 'sender_id'
  acts_as_voter

  class NotAuthorized < MinervaError
    DEFAULT_MESSAGE = '해당 액션에 권한이 없습니다.'
  end
end
