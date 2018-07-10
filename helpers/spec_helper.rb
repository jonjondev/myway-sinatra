# frozen_string_literal: true

# A helper file made to be run before specs for setup

ENV['RACK_ENV'] = 'test'

# Runs code coverage features
require 'simplecov'
SimpleCov.start

# Requires the necessary gems
require 'sinatra'
require 'rspec'
require 'rack/test'
require 'redis'

# Requires all run project files
require File.expand_path(File.join('config', 'application'))

# Requires authentication tools
require File.expand_path(File.join('helpers', 'auth_helper'))

# Gives Rspec access to Rack/Test methods
RSpec.configure do |config|
  config.include Rack::Test::Methods
end

# Sets up the testing environment
set :environement, :test

# shared examples
RSpec.shared_examples 'forbidden example' do
  it 'returns forbidden' do
    expect(last_response).to be_forbidden
  end
end

RSpec.shared_examples 'success example' do
  it 'returns a success' do
    expect(last_response).to be_ok
  end
end

RSpec.shared_examples 'bad route example' do
  it 'routes to an error' do
    get '/probablyanotfounderror'
    expect(last_response).not_to be_ok
  end
end
