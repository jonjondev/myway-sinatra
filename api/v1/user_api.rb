# frozen_string_literal: true

# An api controller for the user model
class UserApi < BaseApi
  before do
    @user = token_authenticate(fetch_token)
    error_response('Missing or invalid auth-token') unless @user
  end

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
  put '/:id' do
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
    @user.to_json if @user.save
  end

  def user_params
    { first_name: params[:first_name] || @user.first_name,
      last_name: params[:last_name] || @user.last_name,
      email: params[:email] || @user.email,
      password_hash: params[:password] || @user.password_hash }
  end
end
