# A controller for the example module
class ExampleApi < BaseApi

	# Returns a JSON object to the client at localhost:9292/api/v1/example
  get '/' do
	  { title: 'an example value', body: api_test }.to_json
	end

	# Returns a JSON object to the client at localhost:9292/api/v1/example/0
	get '/:id' do |i|
	  { content_id: i }.to_json
	end

end