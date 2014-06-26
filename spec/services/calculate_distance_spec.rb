require 'spec_helper'

# Coordinates generated with http://www.geoplaner.com/?z=12;p=37.3148,-122.06159;p=37.29951,-121.98469;p=37.34101,-122.01901;
describe CalculateDistance do
  subject { CalculateDistance }
  let(:user) { create(:user,
                      current_latitude: 37.31480,
                      current_longitude: -121.98469 ) }
  let(:first) { create(:user,
                       current_latitude: 37.31480,
                       current_longitude: -122.06159 ) }

  it 'is true when a user is within 1 mile' do
    expect(subject.call(user: user, connection: first)).to eql true
  end

  it 'is false when a user is too far away' do
    first.current_latitude = 37.33528
    first.current_longitude = -122.156

    expect(subject.call(user: user, connection: first)).to eql false
  end
end
