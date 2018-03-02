# An api controller for the user model
class UserApi < BaseApi

	# index
  get '/' do
  	load_users
	  @users.to_json
	end

	# show
	get '/:id' do
  	load_user
	  @user.to_json
	end

	# create
	post '/' do
	  @user = User.new
	  build_user
	  save_user
	end

	# update
	patch '/:id' do
	  load_user
	  build_user
	  save_user
	end

	# destroy
	delete '/:id' do
		load_user
		@user.destroy
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
	  	@user.to_json
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