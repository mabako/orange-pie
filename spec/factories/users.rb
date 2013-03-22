FactoryGirl.define do
  factory :user do
    name 'Joe'
    email 'joe@example.com'
    password 'changeme'
    password_confirmation 'changeme'
  end
end
