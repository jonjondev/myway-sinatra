# Base api controller used for authentication and setup
class BaseApi < Sinatra::Base
	helpers ApplicationHelper
	helpers ApiHelper
	
	before do
    content_type :json
  end

	not_found do
    status 400
    {:result => 'error', :message => "There was an error in getting your JSON"}.to_json
  end

end