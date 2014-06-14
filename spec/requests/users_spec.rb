require 'spec_helper'

describe "Users API", type: :request do
  before(:context) do
    @accept_json = { "Accept" => "application/json" }
    @json_content_type = { "Content-Type" => "application/json" }
    @accept_and_return_json = @accept_json.merge(@json_content_type)
  end

  describe "GET /api/v1/users" do
    before(:context) do
      @user = create :user
      @headers = @accept_json.merge("Authorization" => @user.handshake_access_token)
    end

    it 'returns a user object with a given username' do
      get "/api/v1/users/#{@user.user_name}", {}, @headers
      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      expect(body).to be_valid_against_schema('user')
    end

    it 'returns an error if the token given is not for the requested user' do
      invalid = create :user

      get "/api/v1/users/#{invalid.user_name}", {}, @headers
      expect(response.status).to eq 401
    end
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
      post '/api/v1/users', user_params.to_json, @accept_and_return_json

      expect(response.status).to eq 201 # created
      created = User.find_by_email('camdub@gmail.com')
      expect(created.handshake_access_token).not_to be_empty
    end
  end
end
