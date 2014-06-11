require 'spec_helper'

describe "Users API", type: :request do
  describe "GET /api/v1/users" do
    it 'works' do
      get "/api/v1/users", {}, { "Accept" => "application/json" }
      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      expect(body).to be_valid_against_schema('user')
      expect(body['a']).to equal(5)
    end
  end
end
