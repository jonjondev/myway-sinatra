# A helper file made to be run before specs for setup

# Runs code coverage features
require 'simplecov'
SimpleCov.start

# Reuqires the necessary gems
require 'sinatra'
require 'rspec'
require 'rack/test'

# Requires all run project files
require File.expand_path(File.join('config', 'application'))

# Gives Rspec access to Rack/Test methods
RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

# Sets up the testing environment
ENV['RACK_ENV'] = 'test'
set :environement, :test