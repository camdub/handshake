# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account_setting do
    user
    setting
    enabled 'false'
  end
end

