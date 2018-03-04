# Base controller used for authentication and setup
class ApplicationController < Sinatra::Base
	helpers AuthenticationHelper
	helpers ApplicationHelper
	
	set :public_folder, File.expand_path('../../public', __FILE__)
	set :views, File.expand_path('../../views', __FILE__)

	configure :development, :test do
	  register Sinatra::Reloader
	  enable :logging
	end

	# home
	get '/' do
		erb :home
	end

	# signup
	get '/signup' do
	  erb :'sessions/sign_up'
	end

	# login
	get '/login' do
	  erb :'sessions/login'
	end

	not_found do
    erb :'error/not_found'
  end

end