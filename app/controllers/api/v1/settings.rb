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

              #user = User.find_by_user_name(params[:username])

              accountsettings = AccountSetting.where(user_id: 1).all #User.find_by_user_name(params[:username]).account_settings
              userprofiles = UserProfile.where(user_id: 1).all #User.find_by_user_name(params[:username]).user_profiles

              present :user_account_settings, accountsettings, with: API::V1::Entities::AccountSetting
              present :user_profile_settings, userprofiles, with: API::V1::Entities::UserProfile
            end

            desc "Set a user's settings"
            params do
              requires :account_setting, type: Hash, desc: "User's account status"
              requires :user_profile, type: Hash, desc: "User profile data"
            end

            post do
                #ap permitted_params[:account_setting]
                #ap permitted_params[:user_profile]

                #user = User.find_by_user_name(params[:username])
                #ap user

                #ap User.first.account_settings

                #user = User.create!(permitted_params[:user])
                #permitted = permitted_params[:accountsettings]
                #ap permitted

                #accountsettings = AccountSetting.where(user_id: 1)
                #userprofiles = UserProfile.where(user_id: 1)
=begin
                accountsettings = params[:accountsettings]
                accountsettings.save

                userprofiles = params[:userprofiles]
                userprofiles.save
=end
                self.status(200)
            end
          end
        end
      end
    end
  end
end
