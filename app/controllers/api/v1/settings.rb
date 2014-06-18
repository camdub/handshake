module API
  module V1
    class Settings < Grape::API
      version 'v1'
      format :json

      resource :users do
          params do
            requires :username, type: String, desc: "username"
          end
        route_param :username do
          resource :settings do
            desc "Return a user's settings"
            get do
              user = User.find_by_user_name(params[:username])
              
              ap "settings controller"
              ap user
              ap user.user_name

              accountsettings = AccountSetting.where(user_id: 1).all #User.find_by_user_name(params[:username]).account_settings
              userprofiles = UserProfile.where(user_id: 1).all #User.find_by_user_name(params[:username]).user_profiles

              present :user_account_settings, accountsettings, with: API::V1::Entities::AccountSetting
              present :user_profile_settings, userprofiles, with: API::V1::Entities::UserProfile
              #present user, with: API::V1::UserEntity
            end
          end
        end
      end
    end
  end
end
