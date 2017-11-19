# Require the application config file
require File.expand_path(File.join('config', 'application'))

# Define all modules here as routes
map('/example') { run ExampleController }

# Must define base route here (at the bottom)
map('/') { run ApplicationController }