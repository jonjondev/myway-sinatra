# frozen_string_literal: true

# Requires the spec_helper containing code to set up testing
require File.expand_path(File.join('helpers', 'spec_helper'))

require 'securerandom'

# Test for registrations controller routes
describe 'RegistrationsController' do
  # Defines app as the tested controller
  def app
    RegistrationsController
  end

  # create
  describe 'create route' do
    def call_create_route
      @email = "#{SecureRandom.hex}@#{SecureRandom.hex}.com"
      post "/?email=#{@email}&password=password&first_name=Test&last_name=User"
    end

    describe 'when unauthenticated' do
      before(:each) do
        call_create_route
      end

      it 'redirects' do
        expect(last_response).to be_redirect
      end

      it 'creates the user with the correct details' do
        @user = User.last(:id)
        expect(@user.first_name).to eq('Test')
        expect(@user.last_name).to eq('User')
        expect(@user.email).to eq(@email)
        expect(@user.password_hash).to eq('password')
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
