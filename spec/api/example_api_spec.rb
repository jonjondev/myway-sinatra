# Requires the spec_helper conteiniing code to set up testing
require File.expand_path(File.join('helpers', 'spec_helper'))

# Test for example api routes
describe 'ApplicationController' do

	# Defines app as base api
  def app
    ExampleApi
  end

  describe 'index route' do
  	before(:each) do
	    get '/'
	  end

	  it "returns a success" do
		  expect(last_response).to be_ok
		end

		it "it returns the right params" do
		  parsed_body = JSON.parse(last_response.body)
		  expect(parsed_body["title"]).to eq("an example value")
		  expect(parsed_body["body"]).to eq("this is text from the api helper")
		end

	end

	describe 'show route' do
  	before(:each) do
  		@id = "765412"
	    get '/' + @id
	  end

	  it "returns a success" do
		  expect(last_response).to be_ok
		end

		it "it returns the right params" do
		  parsed_body = JSON.parse(last_response.body)
		  expect(parsed_body["content_id"]).to eq(@id)
		end

	end

	it "routes to a 404" do 
	  get '/probably/a/notfound/error'
	  expect(last_response).not_to be_ok
	end
end