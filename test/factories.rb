FactoryBot.define do
  factory :space do
    name "MyString"
    url "MyString"
    is_public false
    user nil
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
    spin
  end
end