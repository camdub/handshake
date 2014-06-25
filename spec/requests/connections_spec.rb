require 'spec_helper'

describe API::V1::Connections, type: :request do

    let(:user) { create :user, current_latitude: 37.31480, current_longitude: -121.98469, linkedin_id: 'bp_g8y1ig1' }
    let!(:first) { create(:user,
      first_name: 'David',
      last_name: 'Sulkin',
      current_latitude: 37.31480,
      current_longitude: 122.06159,
      linkedin_id: '9RWG5uWM7v'
    ) }

  describe 'GET /api/v1/connections/:username', vcr: { cassette_name: 'profile' } do
    it 'fetches a user\'s handshake LinkedIn connections'
  end
end
