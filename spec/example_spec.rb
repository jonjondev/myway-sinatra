require File.expand_path(File.join('helpers', 'spec_helper'))

describe 'ExampleController' do
  def app
    ExampleController
  end

  it "routes to example" do 
	  get '/'
	  expect(last_response).to be_ok
	end

	it "routes to a 404" do 
	  get '/probablyanotfounderror'
	  expect(last_response).not_to be_ok
	end
end