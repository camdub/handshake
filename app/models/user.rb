class User < ActiveRecord::Base
	has_many	:user_profiles
	has_many	:account_settings
end
