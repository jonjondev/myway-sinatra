# frozen_string_literal: true

# An api controller for session routes
class SessionsApi < BaseApi
  before do
    request.body.rewind
    @request_payload = JSON.parse(request.body.read)
  end

  # create
  post '/' do
    @user = User.first(email: @request_payload['email'])
    generate_token(@user).to_json if !@user.nil? && verify_password?
  end

  # destroy
  delete '/' do
    invalidate_token(@request_payload['auth_token']).to_json
  end

  private

  def verify_password?
    @user.password_hash == @request_payload['password']
  end
end