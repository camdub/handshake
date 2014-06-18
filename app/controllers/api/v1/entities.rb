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
    end
  end
end
