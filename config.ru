# frozen_string_literal: true

# Require the application config file
require File.expand_path(File.join('config', 'application'))

use Rack::MethodOverride

use Rack::Session::Cookie, key: 'rack.session',
                           path: '/',
                           expire_after: 2_592_000,
                           secret: 'some_secret'

# Define all web modules here as routes
map('/sessions') { run SessionsController }
map('/registrations') { run RegistrationsController }
map('/users') { run UserController }

# Define all api modules here as routes
map('/api') do
  map('/v1') do
    map('/sessions') { run SessionsApi }
    map('/users') { run UserApi }
  end
  run BaseApi
end

# Must define base route here (at the bottom)
map('/') { run ApplicationController }
