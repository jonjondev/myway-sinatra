# A controller for the registrations module
class RegistrationsController < ApplicationController

	# create
	post '/' do
		redirect '/' if logged_in?
	  @password_hash = BCrypt::Password.create(params[:password])
	  create_user
	end

	private

	def create_user
		@user = User.new
	  build_user
	  save_user
	end

	def build_user
		@user.attributes = user_params
	end

	def save_user
		if @user.save!
	  	redirect '/login'
	  end
	end

	def user_params
  	{ first_name: get_param(@user, :first_name), 
	  	last_name: get_param(@user, :last_name),
	  	email: get_param(@user, :email),
	  	password_hash: @password_hash }
	end

end