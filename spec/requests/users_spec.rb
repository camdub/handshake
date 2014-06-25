require 'spec_helper'

describe API::V1::Users, type: :request do
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
      { user: attributes_for(:user) }
    end

    it 'creates a user with an access token' do
      post '/api/v1/users', user_params.to_json, @accept_and_return_json

      expect(response.status).to eq 201 # created
      expect(JSON.parse(response.body)['handshake_access_token']).not_to be_empty
      expect(response.body).to be_valid_against_schema('user')
    end

  end

  describe 'POST /api/v1/users/:user_name' do
    before(:context) do
      @user = create :user
      @headers = @accept_json.merge("Authorization" => @user.handshake_access_token)
    end

    it 'updates a user\'s location with given long and lat' do
      locale_params = {
        user: {
          current_latitude: '12.325',
          current_longitude: '-23.234'
        }
      }

      post "/api/v1/users/#{@user.user_name}", locale_params, @headers
      @user.reload
      expect(response.status).to eq 200
      expect(@user.current_latitude).not_to be_nil
      expect(@user.current_longitude).not_to be_nil
    end
  end

  describe "POST /api/v1/users/authenticate" do
    let(:endpoint) { '/api/v1/users/authenticate' }
    let(:valid_user_params) do
      {
        user: {
          email: 'camdub@gmail.com',
          password: 'testing123'
        }
      }
    end
    let(:invalid_user_params) do
      invalid_user_params = valid_user_params
      invalid_user_params[:user][:password] = 'invalid123'
      invalid_user_params
    end

    before(:context) do
      create :user, email: 'camdub@gmail.com', password: 'testing123'
    end

    it 'authenticates a user with valid user_name and password' do
      post endpoint, valid_user_params.to_json, @accept_and_return_json

      expect(response.status).to eq 200
      expect(JSON.parse(response.body)['handshake_access_token']).not_to be_nil
    end

    it 'returns an error with invalid credentials' do
      post endpoint, invalid_user_params.to_json, @accept_and_return_json
      expect(response.status).to eq 422
    end

    it 'returns and error with an invalid email' do
      invalid_user_params[:user][:email] = 'fail@gmail.com'
      post endpoint, invalid_user_params.to_json, @accept_and_return_json
      expect(response.status).to eq 404
    end
  end
end
