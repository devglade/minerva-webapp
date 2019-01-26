class Space < ApplicationRecord
  belongs_to :user
  has_many :projects
  has_many :space_members
  has_many :users, through: :space_members
  has_many :invitations

  scope :mine, ->(user_id) {where(user_id: user_id).order('created_at DESC')}
  scope :opend, -> {where("is_public =?", true)}
  scope :contains_keyword, ->(query) {where("name LIKE ?", "#{query}%")}
  validates_format_of :url, with: /[A-Za-z0-9]+/, message: "URL은 영어와 숫자만 허용됩니다", on: :create


  def updatable_by?(current_user)
    current_user.id == user_id
  end

  after_create do |space|
    SpaceMember.create(space_id: space.id, user_id: space.user_id)
  end

  def isAllowed current_user_id
    users.exists?(current_user_id)
  end
end
