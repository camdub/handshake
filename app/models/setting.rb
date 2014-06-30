class Setting < ActiveRecord::Base
	has_many	:account_settings, autosave: true
end
