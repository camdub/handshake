# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account_setting do
  	user_id '1'
  	setting_id '1'
  	enabled 'false'
  end
end
