module API
  module V1
    module ErrorFormatter
      def self.call(message, backtrace, options, env)
        { message: message }
      end
    end

    class Base < Grape::API
      error_formatter :json, API::V1::ErrorFormatter
      mount API::V1::Users
    end
  end
end
