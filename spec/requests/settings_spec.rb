require 'spec_helper'

describe "Settings API", type: :request do

	#let(:user_account_settings) { create :account_setting }
	#let(:user_profile_settings) { create :user_profile }
	#let(:user) {create :user}

  describe "GET /api/v1/settings" do

    it 'works' do
    	#user = FactoryGirl.create :user
      #account_setting = FactoryGirl.create :account_setting

      user = FactoryGirl.create :user
			user_account_setting = FactoryGirl.create :account_setting
			user_profile_setting = FactoryGirl.create :user_profile

      #get "/api/v1/users/#{user.user_name}/settings", {}, { "Accept" => "application/json" }
      #expect(response.status).to eq 200

      #body = JSON.parse(response.body)
      #ap "body printout"
      #ap body
      #ap user_account_settings
      #ap user_profile_settings
      #ap user

      #expect(body).to be_valid_against_schema('setting')
    end
  end
end
