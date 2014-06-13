module API
  class Base < Grape::API
    helpers do
      def permitted_params
        @permitted_params ||= declared(params, include_missing: false)
      end
    end

    mount API::V1::Base
  end
end
