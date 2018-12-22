FactoryBot.define do
  factory :invitation do
    
  end
  factory :space_member do
    
  end
  factory :space do
    name Forgery(:lorem_ipsum).words(10)
    url Forgery('internet').domain_name
    is_public Forgery('basic').boolean
    user
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
    space
  end

  factory :spin do
    status 1
    title {Forgery(:lorem_ipsum).words(20)}
    summary {Forgery(:lorem_ipsum).words(20)}
    project
    user
  end

  factory :section do
    title {Forgery(:lorem_ipsum).words(20)}
    order 0
    spin
  end

  factory :post do
    content {Forgery(:lorem_ipsum).words(20)}
    user
    section
    spin
  end
end