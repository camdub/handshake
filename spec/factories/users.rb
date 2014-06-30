# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  # the default linkedin_id here is Cameron's
  factory :user do
    sequence(:user_name) { |n| "user#{n}" }
    first_name 'Cameron'
    last_name 'Woodmansee'
    sequence(:email) { |n| "email#{n}@handshake.com" }
    password 'testing123'
    linkedin_id 'bp_g8y1ig1'
    phone_number '760-234-2345'

    factory :user_with_settings do
      after(:create) do |user, evaluator|
        tmpSetting = create :setting
        create_list(:account_setting, 2, user: user, setting: tmpSetting)

        tmpProfileType = create :profile_type
        create_list(:user_profile, 2, user: user, profile_type: tmpProfileType)
      end
    end
  end
end
