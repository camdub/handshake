require 'hashie'

module API
  module V1
    class Connections < Grape::API
      version 'v1'
      format :json

      resource :connections do
        desc "Get a user's connections of a certain type"
        params do
          requires :username, type: String, desc: 'the user to get connections for'
        end
        route_param :username do
          get do
            authorize

            user = User.find_by_user_name(params[:username])
            first = FindNearbyConnections.call(user: user, connection_type: 'first')

            # format profileUrl
            first.map { |i| i.siteStandardProfileRequest = i.siteStandardProfileRequest.url }

            data = Hashie::Mash.new({ connections: first, type: 'first' })
            present data, with: API::V1::Entities::ConnectionsArray
          end
        end
      end

    end
  end
end
