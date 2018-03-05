# A helper file made to be run before specs for setup

ENV['RACK_ENV'] = 'test'

# Runs code coverage features
require 'simplecov'
SimpleCov.start

# Reuqires the necessary gems
require 'sinatra'
require 'rspec'
require 'rack/test'
require 'pry'

# Requires all run project files
require File.expand_path(File.join('config', 'application'))

# Gives Rspec access to Rack/Test methods
RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

# Sets up the testing environment
set :environement, :test

# Provides a mock login function
def sign_in_user
	if (User.first(email: "greatest@ever.com").nil?)
  	User.create(first_name: "Test", last_name: "User", email: "test@user.com", password_hash: BCrypt::Password.create("password"))
  end
	env "rack.session", { email: "test@user.com" }
end