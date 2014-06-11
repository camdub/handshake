module API
  module V1
    class UserEntity < Grape::Entity
      expose :user_name
      expose :first_name
      expose :last_name
      expose :email
      expose :phone_number
      expose :handshake_access_token
    end

    class Users < Grape::API
      version 'v1'
      format :json

      resource :users do
        desc "Return a user's basic information"
        params do
          requires :username, type: String, desc: "username"
        end
        route_param :username do
          get do
            user = User.find_by_user_name(params[:username])
            present user, with: API::V1::UserEntity
          end
        end
      end
    end
  end
end
