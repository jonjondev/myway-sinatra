# frozen_string_literal: true

# Require the application config file
require File.expand_path(File.join('config', 'application'))

use Rack::MethodOverride

# Define all api modules here as routes
map('/api') do
  map('/sessions') { run SessionsApi }
  map('/v1') do
    map('/users') { run UserApi }
  end
  run BaseApi
end
