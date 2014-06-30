# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_profile do
    user
    profile_type
    handshake_user_name 'false'
    full_name 'false'
    company 'false'
    title 'false'
    picture 'false'
    phone_number 'false'
  end
end
