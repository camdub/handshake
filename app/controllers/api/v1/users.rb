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

        desc "Authenticates a user with user_name and password"
        params do
          requires :user, type: Hash, desc: "user fields"
        end
        post '/authenticate' do
          user = User.find_by_email(permitted_params[:user][:email])

          if user.nil?
            error!("A User with that email doesn't exist", 404)
          elsif not user.valid_password?(permitted_params[:user][:password])
            error!("Wrong Password", 422)
          end

          self.status(200)
          present user, with: API::V1::Entities::UserToken
        end

      end # end user resource
    end
  end
end
