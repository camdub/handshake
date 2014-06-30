module API
  module V1
    module Entities
      class User < Grape::Entity
        expose :user_name
        expose :first_name
        expose :last_name
        expose :email
        expose :phone_number
        expose :handshake_access_token
      end

      class UserToken < Grape::Entity
        expose :handshake_access_token
      end

      class AccountSettingEntity < Grape::Entity
        expose :description
      end

      class AccountSetting < Grape::Entity
        expose :setting, using: API::V1::Entities::AccountSettingEntity
        expose :enabled
      end

      class ProfileTypeEntity < Grape::Entity
        expose :connection_type
      end

      class UserProfile < Grape::Entity
        expose :profile_type, using: API::V1::Entities::ProfileTypeEntity
        expose :handshake_user_name
        expose :full_name
        expose :company
        expose :title
        expose :picture
        expose :phone_number
      end
    end
  end
end
