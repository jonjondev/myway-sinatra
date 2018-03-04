# A controller for the user module
class UserController < ApplicationController
	helpers UserHelper

	# index
  get '/' do
  	load_users
	  erb :'user/index'
	end

	# new
	get '/new' do
	  @user = User.new
	  build_user
	  erb :'user/new'
	end

	# show
	get '/:id' do
  	load_user
	  erb :'user/show'
	end

	# create
	post '/' do
	  @user = User.new
	  build_user
	  save_user
	end

	# edit
	get '/:id/edit' do
  	load_user
	  erb :'user/edit'
	end

	# update
	put '/:id' do
	  load_user
	  build_user
	  save_user
	end

	# destroy
	delete '/:id' do
		load_user
		@user.destroy
		redirect "/users"
	end

	private

	def load_users
		@users = User.all
	end

	def load_user
		@user = User.get(params[:id])
	end

	def build_user
		@user.attributes = user_params
	end

	def save_user
		if @user.save
	  	redirect "users/#{@user.id}"
	  end
	end

	def user_params
  	{ first_name: get_param(@user, :first_name), 
	  	last_name: get_param(@user, :last_name),
	  	email: get_param(@user, :email),
	  	salt: get_param(@user, :salt),
	  	password_hash: get_param(@user, :password_hash) }
	end

end