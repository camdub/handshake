class UserProfile < ActiveRecord::Base
	belongs_to	:user
	belongs_to	:profile_type
end
