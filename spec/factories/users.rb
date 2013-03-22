FactoryGirl.define do
  factory :user do
    name 'Joe'
    email 'joe@example.com'
    password 'changeme'
    password_confirmation 'changeme'
  end

  factory :admin, :class => :user do
    name 'mabako'
    email 'mabako@example.com'
    password 'yeahright'
    password_confirmation 'yeahright'
    admin 1
  end
end
