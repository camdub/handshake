class ProfileType < ActiveRecord::Base
	has_many :user_profiles
end
