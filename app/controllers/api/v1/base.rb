module API
  module V1
    module ErrorFormatter
      def self.call(message, backtrace, options, env)
        { message: message }
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
      end

      mount API::V1::Users
    end
  end
end
