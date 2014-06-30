require 'spec_helper'
require 'active_model/errors'

describe FindNearbyConnections do
  subject { FindNearbyConnections }
  let(:user) { create(:user) }

  it { expect { subject.call(geocoder: proc {}, connections: proc {}) }.to raise_error(ActiveModel::StrictValidationFailed) }
  it { expect { subject.call(user: user, geocoder: proc {}, connections: proc {}) }.to raise_error(ActiveModel::StrictValidationFailed) }

  it 'returns arrary of connections' do
    nearby = subject.call(
      user: user,
      connection_type: 'first',
      geocoder: proc { true },
      connections: proc { [ create(:user) ] }
    )
    expect(nearby).not_to be_empty
  end
end
