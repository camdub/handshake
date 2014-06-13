require 'spec_helper'

describe "User", :type => :model do

  describe "Creating Handshake access token" do
    it "calls the generate token callback on save" do
      user = build :user
      expect(user).to receive(:ensure_access_token)

      user.save
    end

    it "generates a token for when a user is created" do
      user = create :user
      expect(user.handshake_access_token).not_to be_empty
    end
  end

end
