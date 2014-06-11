module API
  module V1
    class Users < Grape::API
      version 'v1'
      format :json

      resource :users do
        desc "return user info"
        get do
          { 'a' => 5 }
        end
      end
    end
  end
end
