require 'spec_helper'

describe API::V1::Connections, type: :request do
  before(:context) do
    @accept_json = { "Accept" => "application/json" }
    @json_content_type = { "Content-Type" => "application/json" }
    @accept_and_return_json = @accept_json.merge(@json_content_type)
  end

  let!(:first) { create(:user,
                        first_name: 'David',
                        last_name: 'Sulkin',
                        current_latitude: 37.31480,
                        current_longitude: -122.06159,
                        linkedin_id: '9RWG5uWM7v'
                       ) }

  describe 'GET /api/v1/connections/:username', vcr: { cassette_name: 'profile' } do
    before(:context) do
      @user = create(:user,
                     current_latitude: 37.31480,
                     current_longitude: -121.98469,
                     linkedin_id: 'bp_g8y1ig1',
                     linkedin_access_token: ENV['TEST_TOKEN']
                    )
      @headers = @accept_json.merge("Authorization" => @user.handshake_access_token)
    end

    it 'fetches a user\'s handshake LinkedIn connections' do
      get "/api/v1/connections/#{@user.user_name}", {}, @headers
      expect(response.body).to be_valid_against_schema('connections')
    end

    it 'is empty when no users are nearby' do
      first.current_longitude = 122.06159
      first.save
      get "/api/v1/connections/#{@user.user_name}", {}, @headers
      expect(JSON.parse(response.body)['connections']).to be_empty
    end
  end
end
