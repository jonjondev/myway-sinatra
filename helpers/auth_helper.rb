# frozen_string_literal: true

require 'redis'

# Module for authentication helper methods
module AuthHelper

  def token_authenticate(token)
    redis = Redis.new
    User.get(redis.get(token))
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
    redis.del(auth_token) == 1
  end

  def fetch_token
    request.env['HTTP_AUTH_TOKEN']
  end
end
