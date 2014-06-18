# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:user_name) { |n| "user#{n}" }
    first_name 'cameron'
    last_name 'wood'
    sequence(:email) { |n| "email#{n}@handshake.com" }
    password 'testing123'
    phone_number '760-234-2345'
  end
end
