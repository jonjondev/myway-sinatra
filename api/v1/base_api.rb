# frozen_string_literal: true

# Base api controller used for authentication and setup
class BaseApi < Sinatra::Base
  helpers AuthHelper
  helpers ApiHelper

  configure :development, :test do
    register Sinatra::Reloader
    enable :logging
  end

  before do
    content_type :json
  end

  get '/' do
    api_test.to_json
  end

  not_found do
    error_response('There was an error getting your JSON')
  end
end
