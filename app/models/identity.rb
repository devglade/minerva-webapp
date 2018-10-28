class Identity < ApplicationRecord
  belongs_to :user
  validates :uid, :provider, presence: true
  validates :uid, uniqueness: {:scope => :provider}

  # 파라미터로 받은 auth 인수를 이용하여 provider와 uid가 일치하는 사용자를 검색해 보고 없으면 새로 identity 객체를 생성하고 이미 존재할 경우에는 해당 identity 객체를 반환한다.
  def self.find_for_oauth(auth)
    identity = find_by(provider: auth.provider, uid: auth.uid)
    identity = create(uid: auth.uid, provider: auth.provider) if identity.nil?
    identity
  end
end
