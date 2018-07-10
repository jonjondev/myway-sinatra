# frozen_string_literal: true

# An api controller for session routes
class SessionsApi < BaseApi
  before do
    request.body.rewind
    begin
      @request_payload = JSON.parse(request.body.read)
    rescue JSON::JSONError
      error_response('Couldn\'t find any JSON in request body')
    end
  end

  # create
  post '/' do
    @user = User.first(email: @request_payload['email'])
    if !@user.nil? && verify_password?
      { auth_token: generate_token(@user) }.to_json
    end
  end

  # destroy
  delete '/' do
    { result: invalidate_token(@request_payload['auth_token']) }.to_json
  end

  private

  def verify_password?
    @user.password_hash == @request_payload['password']
  end
end