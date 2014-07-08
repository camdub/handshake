module API
  module V1
    module Entities
      class User < Grape::Entity
        expose :first_name
        expose :last_name
        expose :email
        expose :handshake_access_token
        expose :linkedin_id
      end

      class UserToken < Grape::Entity
        expose :handshake_access_token
      end

      class AccountSettingEntity < Grape::Entity
        expose :description
      end

      class Connections < Grape::Entity
        format_with(:decimal) { |ll| ll.to_f }

        expose :first_name
        expose :last_name

        with_options(format_with: :decimal) do
          expose :current_latitude
          expose :current_longitude
        end

        expose :pictureUrl, as: :picture_url
        expose :siteStandardProfileRequest, as: :profile_url
        expose :industry
        expose :headline
        expose :location
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

      class ConnectionsArray < Grape::Entity
        expose :type, as: :connection_type
        expose :connections, using: API::V1::Entities::Connections
      end

    end
  end
end
