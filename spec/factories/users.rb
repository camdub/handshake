# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    user_name 'camdub'
    first_name 'cameron'
    last_name 'wood'
    email "test@handshake.com"
    password 'testing123'
    phone_number '760-234-2345'
  end
end
