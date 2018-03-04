# Requires the spec_helper containing code to set up testing
require File.expand_path(File.join('helpers', 'spec_helper'))

# Test for user api routes
describe 'UserApi' do

	# Defines app as base api
  def app
    UserApi
  end

  describe 'create route' do
  	before(:each) do
	    post '/?first_name=Greatest&last_name=Ever'
	  end

	  it "returns a success" do
		  expect(last_response).to be_ok
		end

		it "returns the right user" do
			@user = User.last(:id)
		  expect(@user.first_name).to eq("Greatest")
		  expect(@user.last_name).to eq("Ever")
		end
	end

	describe 'update route' do
  	before(:each) do
	    put "/#{User.last(:id).id}?email=greatest@ever.com"
	  end

	  it "returns a success" do
		  expect(last_response).to be_ok
		end

		it "returns the right user" do
			@user = User.last(:id)
		  expect(@user.email).to eq("greatest@ever.com")
		end
	end

  describe 'index route' do
  	before(:each) do
	    get '/'
	  end

	  it "returns a success" do
		  expect(last_response).to be_ok
		end

		it "returns the right users" do
		  expect(last_response.body).to eq(User.all.to_json)
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

		it "returns the right user" do
		  parsed_body = JSON.parse(last_response.body)
		  expect(parsed_body['id']).to eq(@id)
		end
	end

	describe 'destroy route' do
  	before(:each) do
  		@user = User.last(:id)
	    delete "/#{@user.id}"
	  end

		it "deletes the user" do
			expect(last_response).to be_ok
		  expect(User.last(:id)).not_to eq(@user)
		end
	end

	it "routes to a 404" do 
	  get '/probably/a/notfound/error'
	  expect(last_response).not_to be_ok
	end
end