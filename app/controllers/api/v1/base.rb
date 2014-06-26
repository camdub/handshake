module API
  module V1
    module ErrorFormatter
      def self.call(message, backtrace, options, env)
        { message: message }.to_json
      end
    end

    class Base < Grape::API
      error_formatter :json, API::V1::ErrorFormatter

      helpers do
        def permitted_params
          @permitted_params ||= declared(params, include_missing: false)
        end

        def authenticate
          token = headers['Authorization']
          token && User.find_by_handshake_access_token(token)
        end

        def authorize(user_param = :username)
          unless authenticate && params[user_param]
            error!("Unauthorized", 401)
          end

          user_token = User.find_by_user_name(params[user_param]).handshake_access_token
          if headers['Authorization'] != user_token
            error!("Unauthorized", 401)
          end
        end
      end
      rescue_from :all

      mount API::V1::Users
      mount API::V1::Connections
      mount API::V1::Settings
      add_swagger_documentation base_path: '/api',
                                api_version: 'v1',
                                hide_documentation_path: true
    end
  end
end
