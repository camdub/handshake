module API
  module V1
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
            error!("Unauthorized", 401) unless authenticate

            user = User.find_by_user_name(params[:username])
            if headers['Authorization'] != user.handshake_access_token
              error!("Unauthorized", 401)
            end
            present user, with: API::V1::Entities::User
          end
        end

        desc "Creates a new user and generates a token"
        params do
          requires :user, type: Hash, desc: "user fields"
        end
        post do
          user = User.create(permitted_params[:user])
          present user, with: API::V1::Entities::User
        end
      end
    end
  end
end
