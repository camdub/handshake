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

      class AccountSetting < Grape::Entity
          expose :setting_id
          expose :enabled
      end

      class UserProfile < Grape::Entity
        expose :profile_type_id
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
