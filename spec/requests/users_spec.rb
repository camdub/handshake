require 'spec_helper'

describe "Users API", type: :request do
  describe "GET /api/v1/users" do
    it 'works' do
      user = FactoryGirl.create :user

      get "/api/v1/users/#{user.user_name}", {}, { "Accept" => "application/json" }
      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      expect(body).to be_valid_against_schema('user')
    end
  end
end
