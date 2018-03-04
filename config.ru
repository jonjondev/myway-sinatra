# Require the application config file
require File.expand_path(File.join('config', 'application'))

use Rack::MethodOverride

use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :expire_after => 2592000,
                           :secret => 'some_secret'

# Define all web modules here as routes
map('/users') { run UserController }
map('/sessions') { run SessionsController }
map('/registrations') { run RegistrationsController }

# Define all api modules here as routes
map('/api/v1') {
	map('/users') { run UserApi }
	run BaseApi
}

# Must define base route here (at the bottom)
map('/') { run ApplicationController }