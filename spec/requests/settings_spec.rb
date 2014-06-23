require 'spec_helper'

describe "Settings API", type: :request do
  before(:context) do
    @accept_json = { "Accept" => "application/json" }
    @json_content_type = { "Content-Type" => "application/json" }
    @accept_and_return_json = @accept_json.merge(@json_content_type)
  end

  describe "GET /api/v1/users/username/settings" do
    before(:context) do
      @user = create :user
      @headers = @accept_json.merge("Authorization" => @user.handshake_access_token)

      user_account_setting = FactoryGirl.create :account_setting
      user_profile_setting = FactoryGirl.create :user_profile
    end

    it 'returns a settings object with a given username' do

      get "/api/v1/users/#{@user.user_name}/settings", {}, @headers
      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      expect(body).to be_valid_against_schema('setting')
    end

    it 'returns an error if the token given is not for the requested user' do
      invalid = create :user

      get "/api/v1/users/#{invalid.user_name}/settings", {}, @headers
      expect(response.status).to eq 401
    end
  end

  describe "POST /api/v1/users/username/settings" do
    before(:context) do
      @user = create :user
      @headers = @accept_json.merge("Authorization" => @user.handshake_access_token)

      user_account_setting = FactoryGirl.create :account_setting
      user_profile_setting = FactoryGirl.create :user_profile
    end

    let(:user_params) do
      { account_setting: attributes_for(:account_setting),user_profile: attributes_for(:user_profile)}
    end

    it 'updates a users settings' do

      post "/api/v1/users/#{@user.user_name}/settings", user_params.to_json, @accept_and_return_json

      expect(response.status).to eq 200
    end
  end
end
