module API
  module V1
    #module Entities
      
      #class SettingEntity < Grape::Entity
        #expose :setting_id, using: API::V1::Entities::AccountSettingEntity
        #expose :enabled, using: API::V1::AccountSettingEntity
        #expose :profile_type_id, using: API::V1::ProfileSettingEntity
        #expose :handshake_user_name, using: API::V1::ProfileSettingEntity
        #expose :full_name, using: API::V1::ProfileSettingEntity
        #expose :company, using: API::V1::ProfileSettingEntity
        #expose :title , using: API::V1::ProfileSettingEntity
        #expose :picture, using: API::V1::ProfileSettingEntity
        #expose :phone_number, using: API::V1::ProfileSettingEntity
      #end

      #class AccountSetting < Grape::Entity
          #expose :setting_id
          #expose :enabled
      #end

      #class UserProfile < Grape::Entity
        #expose :profile_type_id
        #expose :handshake_user_name
        #expose :full_name
        #expose :company
        #expose :title 
        #expose :picture
        #expose :phone_number
      #end
    #end

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
              #Creating a join
              #setting = User.joins(:user_profiles).joins(:account_settings).select(:setting_id, :enabled, :profile_type_id, :handshake_user_name, :full_name, :company, :title, :picture, :phone_number)
              
              #Seperate calls

              user = User.find_by_user_name(params[:username])

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
