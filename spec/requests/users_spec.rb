require 'spec_helper'

describe "Users API", type: :request do
  let(:accept_json) { { "Accept" => "application/json" } }
  let(:json_content_type) { { "Content-Type" => "application/json" } }
  let(:accept_and_return_json) { accept_json.merge(json_content_type) }

  describe "GET /api/v1/users" do
    it 'returns a user object with a given username' do
      user = create :user

      get "/api/v1/users/#{user.user_name}", {}, accept_json
      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      expect(body).to be_valid_against_schema('user')
    end

    it 'returns 404 if no user with that username exists' do
      get "/api/v1/users/error", {}, accept_json
      expect(response.status).to eq 404
    end

    it 'returns an error if the token given is not for that user'
  end

  describe "POST /api/v1/users" do
    let(:user_params) do
      {
        user: {
          email: 'camdub@gmail.com',
          password: 'testing123'
        }
      }
    end

    it 'creates a user with an access token' do
      post '/api/v1/users', user_params.to_json, accept_and_return_json

      expect(response.status).to eq 201 # created
      created = User.find_by_email('camdub@gmail.com')
      expect(created.handshake_access_token).not_to be_empty
    end
  end
end
