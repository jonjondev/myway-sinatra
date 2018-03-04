# Require the application config file
require File.expand_path(File.join('config', 'application'))

use Rack::MethodOverride

# Define all web modules here as routes
map('/users') { run UserController }

# Define all api modules here as routes
map('/api/v1') {
	map('/users') { run UserApi }
	run BaseApi
}

# Must define base route here (at the bottom)
map('/') { run ApplicationController }