# frozen_string_literal: true

# Requires the spec_helper containing code to set up testing
require File.expand_path(File.join('helpers', 'spec_helper'))

# Test for sessions controller routes
describe 'SessionsController' do
  # Defines app as the tested controller
  def app
    SessionsController
  end

  def session
    last_request.env['rack.session']
  end

  # create
  describe 'create route' do
    def create_user
      if User.first(email: 'greatest@ever.org').nil?
        hash = BCrypt::Password.create('password')
        User.create(first_name: 'Greatest',
                    last_name: 'Ever',
                    email: 'greatest@ever.org', password_hash: hash)
      end
    end

    def call_create_route
      @user = User.last(:id)
      post "/?email=#{@user.email}&password=password"
    end

    describe 'when unauthenticated' do
      before(:each) do
        create_user
        call_create_route
      end

      it 'adds the user to the session' do
        expect(session[:email]).to eq(@user.email)
      end
    end

    describe 'when authenticated' do
      before(:each) do
        sign_in_user
        call_create_route
      end

      it 'redirects' do
        expect(last_response).to be_redirect
      end

      it 'redirects to home' do
        follow_redirect!
        expect(last_request.url).to eq('http://example.org/')
      end
    end
  end

  it 'routes to a 404' do
    get '/probably/a/not/found/error'
    expect(last_response).not_to be_ok
  end
end
