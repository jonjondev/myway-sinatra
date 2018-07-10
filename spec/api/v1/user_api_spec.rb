# frozen_string_literal: true

# Requires the spec_helper containing code to set up testing
require File.expand_path(File.join('helpers', 'spec_helper'))

# Test for user api routes
describe 'UserApi' do

  # Defines app as base api
  def app
    UserApi
  end

  def create_test_user
    hash = BCrypt::Password.create('password')
    User.create(first_name: 'Test',
                last_name: 'User',
                email: 'test@user.com',
                password_hash: hash)
  end

  # Includes authentication tools
  include AuthHelper

  before :all do
    @user = create_test_user
    @auth_token = generate_token(@user)
  end

  # shared examples
  RSpec.shared_examples 'unauthenticated examples' do
    describe 'when unauthenticated' do
      before :each do
        call_route
      end
      include_examples 'forbidden example'
    end
  end

  # index route
  describe 'index route' do
    let(:call_route) { get '/' }

    include_examples 'unauthenticated examples'

    describe 'when authenticated' do
      before :each do
        header('AUTH_TOKEN', @auth_token)
        call_route
      end

      include_examples 'success example'

      it 'returns all users' do
        expect(last_response.body).to eq(User.all.to_json)
      end
    end
  end

  # show route
  describe 'show route' do
    before(:all) do
      @id = User.first(:id).id
    end

    let(:call_route) { get '/' + @id.to_s }

    include_examples 'unauthenticated examples'

    describe 'when authenticated' do
      before(:each) do
        header('AUTH_TOKEN', @auth_token)
        call_route
      end

      include_examples 'success example'

      it 'returns the right user' do
        parsed_body = JSON.parse(last_response.body)
        expect(parsed_body['id']).to eq(@id)
      end
    end
  end

  # create route
  describe 'create route' do
    let(:call_route) do
      post '/?first_name=Greatest&last_name=Ever&email=dr@ke.com&password=upset'
    end

    include_examples 'unauthenticated examples'

    describe 'when authenticated' do
      before(:each) do
        header('AUTH_TOKEN', @auth_token)
        call_route
      end

      include_examples 'success example'

      it 'creates the user' do
        user = User.last(:id)
        expect(user.full_name).to eq('Greatest Ever')
      end
    end
  end

  # update route
  describe 'update route' do
    let(:call_route) { put "/#{User.last(:id).id}?email=greatest@ever.com" }

    include_examples 'unauthenticated examples'

    describe 'when authenticated' do
      before(:each) do
        header('AUTH_TOKEN', @auth_token)
        call_route
      end

      include_examples 'success example'

      it 'returns the right user' do
        expect(User.last(:id).email).to eq('greatest@ever.com')
      end
    end
  end

  # destroy route
  describe 'destroy route' do
    let(:call_route) do
      create_test_user
      delete "/#{User.last(:id).id}"
    end

    include_examples 'unauthenticated examples'

    describe 'when authenticated' do
      before(:each) do
        header('AUTH_TOKEN', @auth_token)
        call_route
      end

      include_examples 'success example'

      it 'deletes the user' do
        expect(User.last(:id)).not_to eq(@user)
      end
    end
  end

  # bad route
  include_examples 'bad route example'

end
