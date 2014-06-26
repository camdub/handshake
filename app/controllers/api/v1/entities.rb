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

      class ConnectionsArray < Grape::Entity
        expose :type, as: :connection_type
        expose :connections, using: API::V1::Entities::Connections
      end

    end
  end
end
