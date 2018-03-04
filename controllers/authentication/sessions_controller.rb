# A controller for the sessions module
class SessionsController < ApplicationController

	# create
	post '/' do
		@user = User.first(email: params[:email])
    if @user != nil && verify_password?
	    session[:email] = @user.email
	    redirect "/"
    end
	end

	# destroy
	delete '/' do
		session[:email] = nil
  	redirect "/"
	end

	private

	def verify_password?
		@user.password_hash == params[:password]
	end

end