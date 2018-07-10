# frozen_string_literal: true

# Requires the spec_helper containing code to set up testing
require File.expand_path(File.join('helpers', 'spec_helper'))

# Test for user api routes
describe 'SessionsApi' do

  # Defines app as base api
  def app
    SessionsApi
  end

  def create_test_user
    hash = BCrypt::Password.create('password')
    User.create(first_name: 'Session',
                last_name: 'Tester',
                email: 'h@llo.com',
                password_hash: hash)
  end

  # Includes authentication tools
  include AuthHelper

  let(:json_headers) do
    { CONTENT_TYPE: 'application/json',
      'ACCEPT': 'application/json' }
  end

  before :all do
    @user = create_test_user
  end

  # create route
  describe 'create route' do
    let(:call_route) do
      body = { email: @user.email, password: 'password' }.to_json
      post '/', body, json_headers
    end

    before(:each) do
      call_route
    end

    include_examples 'success example'

    it 'returns a valid auth token' do
      auth_token = JSON.parse(last_response.body)['auth_token']
      expect(auth_token).not_to eq(nil)
      expect(token_authenticate(auth_token)).to eq(@user)
    end
  end

  # destroy route
  describe 'destroy route' do
    let(:call_route) do
      @auth_token = generate_token(@user)
      body = { auth_token: @auth_token }.to_json
      delete '/', body, json_headers
    end

    before(:each) do
      call_route
    end

    include_examples 'success example'

    it 'invalidates the auth token' do
      result = JSON.parse(last_response.body)['result']
      expect(result).to eq(true)
      expect(token_authenticate(@auth_token)).to eq(nil)
    end
  end

  # bad route
  include_examples 'bad route example'

end
