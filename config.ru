# Require the application config file
require File.expand_path(File.join('config', 'application'))

# Define all web modules here as routes
map('/example') { run ExampleController }

# Define all api modules here as routes
map('/api/v1') {
	map('/example') { run ExampleApi }
	map('/users') { run UserApi }
	run BaseApi
}

# Must define base route here (at the bottom)
map('/') { run ApplicationController }