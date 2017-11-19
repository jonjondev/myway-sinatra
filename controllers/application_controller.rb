# Base controller used for authentication and setup
class ApplicationController < Sinatra::Base
	helpers ApplicationHelper
	
	set :public_folder, File.expand_path('../../public', __FILE__)
	set :views, File.expand_path('../../views', __FILE__)

	get '/' do
		erb :home
	end

	not_found do
    erb :not_found
  end

end