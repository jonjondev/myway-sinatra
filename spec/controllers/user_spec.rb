# Requires the spec_helper conteiniing code to set up testing
require File.expand_path(File.join('helpers', 'spec_helper'))

# Test for user controller routes
describe 'UserController' do

	# Defines app as the tested controller
  def app
    UserController
  end

	describe 'index route' do
  	before(:each) do
	    get '/'
	  end

	  it "returns a success" do
		  expect(last_response).to be_ok
		end
	end

	describe 'show route' do
  	before(:each) do
  		@id = User.first(:id).id
	    get '/' + @id.to_s
	  end

	  it "returns a success" do
		  expect(last_response).to be_ok
		end
	end

	describe 'new route' do
  	before(:each) do
	    get '/new'
	  end

	  it "returns a success" do
		  expect(last_response).to be_ok
		end
	end

	describe 'edit route' do
  	before(:each) do
  		@user = User.first(:id)
	    get '/' + @user.id.to_s + '/edit'
	  end

	  it "returns a success" do
		  expect(last_response).to be_ok
		end
	end

	describe 'create route' do
  	before(:each) do
	    post '/?first_name=Greatest&last_name=Ever'
	  end

	  it "redirects" do
		  expect(last_response).to be_redirect
		end

		it "redirects to the correct user" do
		  follow_redirect!
		  expect(last_request.url).to include("/users/#{User.last(:id).id}")
		end

		it "creates the user" do
			@user = User.last(:id)
		  expect(@user.first_name).to eq("Greatest")
		  expect(@user.last_name).to eq("Ever")
		end
	end

	describe 'update route' do
  	before(:each) do
  		@user = User.last(:id)
	    put "/#{@user.id}?email=greatest@ever.com"
	  end

	  it "redirects" do
		  expect(last_response).to be_redirect
		end

		it "redirects to the correct user" do
		  follow_redirect!
		  expect(last_request.url).to include("/users/#{User.last(:id).id}")
		end

		it "returns the right user" do
			@user = User.last(:id)
		  expect(@user.email).to eq("greatest@ever.com")
		end
	end

	describe 'destroy route' do
  	before(:each) do
  		@user = User.last(:id)
	    delete "/#{@user.id}"
	  end

	  it "redirects" do
		  expect(last_response).to be_redirect
		end

		it "redirects to the users index" do
		  follow_redirect!
		  expect(last_request.url).to include("/users")
		end

		it "deletes the user" do
		  expect(User.last(:id)).not_to eq(@user)
		end
	end

	it "routes to a 404" do 
	  get '/probably/a/not/found/error'
	  expect(last_response).not_to be_ok
	end
end