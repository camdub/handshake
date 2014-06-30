module API
  module V1
    class Settings < Grape::API
      version 'v1'
      format :json

      resource :users do
        desc "Return a user's settings information"
        params do
          requires :username, type: String, desc: "username"
        end
        route_param :username do
          resource :settings do

            desc "Return a user's settings"
            get do
              error!("Unauthorized", 401) unless authenticate

              user = User.find_by_user_name(params[:username])
              if headers['Authorization'] != user.handshake_access_token
                error!("Unauthorized", 401)
              end

              user = User.find_by_user_name(params[:username])

              accountsettings = user.account_settings
              userprofiles = user.user_profiles

              present :user_account_settings, accountsettings, with: API::V1::Entities::AccountSetting
              present :user_profile_settings, userprofiles, with: API::V1::Entities::UserProfile

            end

            desc "Set a user's settings"
            params do
              requires :account_setting, type: Array, desc: "User's account status"
              requires :user_profile, type: Array, desc: "User profile data"
            end

            post do
                account_setting_param = params[:account_setting]
                user_profile_param = params[:user_profile]

                user = User.find_by_user_name(params[:username])

                user.account_settings.destroy_all
                user.account_settings.build(account_setting_param)

                user.user_profiles.destroy_all
                user.user_profiles.build(user_profile_param)

                self.status(200)
            end
          end
        end
      end
    end
  end
end
