require 'spec_helper'
require 'active_model/errors'

describe GetConnections, vcr: { cassette_name: 'profile' } do
  subject { GetConnections }
  let(:user) { create(:user, linkedin_access_token: ENV['TEST_TOKEN']) }
  let!(:first) { create(:user,
                       first_name: 'David',
                       last_name: 'Sulkin',
                       linkedin_id: '9RWG5uWM7v') }

  it { expect { subject.call(user: nil) }.to raise_error(ActiveModel::StrictValidationFailed) }

  it 'returns handshake users in a user\'s connections' do
    connections = subject.call(user: user)
    expect(connections.length).to eq(1)
  end
end
