# frozen_string_literal: true

require 'redis'

# Module for authentication helper methods
module AuthenticationHelper

  def logged_in?
    session[:email]
  end

  def current_user
    User.first(email: session[:email])
  end

  def authenticate
    redirect '/login' unless logged_in?
  end

  def token_authenticate
    redis = Redis.new
    @user = User.get(redis.get(fetch_token))
  end

  def generate_token(user)
    redis = Redis.new
    auth_token = SecureRandom.urlsafe_base64(64)
    redis.set(auth_token, user.id)
    redis.expire(auth_token, 86_400)
    auth_token
  end

  def invalidate_token(auth_token)
    redis = Redis.new
    redis.del(auth_token)
  end

  def fetch_token
    request.env['HTTP_AUTH_TOKEN']
  end
end
