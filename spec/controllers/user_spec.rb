# frozen_string_literal: true

# Requires the spec_helper containing code to set up testing
require File.expand_path(File.join('helpers', 'spec_helper'))

# Test for user controller routes
describe 'UserController' do
  # Defines app as the tested controller
  def app
    UserController
  end

  # Provides shared examples for login redirection
  RSpec.shared_examples 'unauthenticated examples' do
    it 'does not return a success' do
      expect(last_response).not_to be_ok
    end

    it 'redirects to login' do
      follow_redirect!
      expect(last_request.url).to include('/login')
    end
  end

  # index
  describe 'index route' do
    def call_index_route
      get '/'
    end

    describe 'when unauthenticated' do
      before(:each) do
        call_index_route
      end

      include_examples 'unauthenticated examples'
    end

    describe 'when authenticated' do
      before(:each) do
        sign_in_user
        call_index_route
      end

      it 'returns a success when authenticated' do
        expect(last_response).to be_ok
      end
    end
  end

  # show
  describe 'show route' do
    def call_show_route
      @id = User.first(:id).id
      get '/' + @id.to_s
    end

    describe 'when unauthenticated' do
      before(:each) do
        call_show_route
      end

      include_examples 'unauthenticated examples'
    end

    describe 'when authenticated' do
      before(:each) do
        sign_in_user
        call_show_route
      end

      it 'returns a success' do
        expect(last_response).to be_ok
      end
    end
  end

  # new
  describe 'new route' do
    def call_new_route
      get '/new'
    end

    describe 'when unauthenticated' do
      before(:each) do
        call_new_route
      end

      include_examples 'unauthenticated examples'
    end

    describe 'when authenticated' do
      before(:each) do
        sign_in_user
        call_new_route
      end

      it 'returns a success' do
        expect(last_response).to be_ok
      end
    end
  end

  # edit
  describe 'edit route' do
    def call_edit_route
      @user = User.first(:id)
      get '/' + @user.id.to_s + '/edit'
    end

    describe 'when unauthenticated' do
      before(:each) do
        call_edit_route
      end

      include_examples 'unauthenticated examples'
    end

    describe 'when authenticated' do
      before(:each) do
        sign_in_user
        call_edit_route
      end

      it 'returns a success' do
        expect(last_response).to be_ok
      end
    end
  end

  # create
  describe 'create route' do
    def call_create_route
      post '/?first_name=Greatest&last_name=Ever&email=dr@ke.com&password=hi'
    end

    describe 'when unauthenticated' do
      before(:each) do
        call_create_route
      end

      include_examples 'unauthenticated examples'
    end

    describe 'when authenticated' do
      before(:each) do
        sign_in_user
        call_create_route
      end

      it 'redirects' do
        expect(last_response).to be_redirect
      end

      it 'creates the user' do
        @user = User.last(:id)
        expect(@user.first_name).to eq('Greatest')
        expect(@user.last_name).to eq('Ever')
      end
    end
  end

  # update
  describe 'update route' do
    def call_update_route
      @user = User.last(:id)
      put "/#{@user.id}?email=greatest@ever.com"
    end

    describe 'when unauthenticated' do
      before(:each) do
        call_update_route
      end

      include_examples 'unauthenticated examples'
    end

    describe 'when authenticated' do
      before(:each) do
        sign_in_user
        call_update_route
      end

      it 'redirects' do
        expect(last_response).to be_redirect
      end

      it 'redirects to the correct user' do
        follow_redirect!
        expect(last_request.url).to include("/users/#{User.last(:id).id}")
      end

      it 'returns the right user' do
        @user = User.last(:id)
        expect(@user.email).to eq('greatest@ever.com')
      end
    end
  end

  # destroy
  describe 'destroy route' do
    def call_destroy_route
      @user = User.last(:id)
      delete "/#{@user.id}"
    end

    describe 'when unauthenticated' do
      before(:each) do
        call_destroy_route
      end

      include_examples 'unauthenticated examples'
    end

    describe 'when authenticated' do
      before(:each) do
        sign_in_user
        call_destroy_route
      end

      it 'redirects' do
        expect(last_response).to be_redirect
      end

      it 'redirects to the users index' do
        follow_redirect!
        expect(last_request.url).to include('/users')
      end

      it 'deletes the user' do
        expect(User.last(:id)).not_to eq(@user)
      end
    end
  end

  # error
  it 'routes to a 404' do
    get '/probably/a/not/found/error'
    expect(last_response).not_to be_ok
  end
end
