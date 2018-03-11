FactoryBot.define do
  factory :section do
    
  end
  factory :user do
    name {Forgery(:internet).user_name}
    email {Forgery(:internet).email_address}
    password {Forgery(:basic).password({at_least: 8})}
    password_confirmation {|u| u.password}
    confirmed_at Time.now
  end

  factory :project do
    title {Forgery(:lorem_ipsum).words(20)}
    description {Forgery(:lorem_ipsum).words(20)}
    user
  end

  factory :spin do
    status 1
    title {Forgery(:lorem_ipsum).words(20)}
    summary {Forgery(:lorem_ipsum).words(20)}
    retrospect
    user
  end

  factory :post do
    content {Forgery(:lorem_ipsum).words(20)}
    user
    spin
  end
end