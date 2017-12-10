ENV['RACK_ENV'] = 'test'

require 'sinatra'

require File.expand_path(File.join('config', 'application'))
require 'rspec'
require 'rack/test'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

set :environement, :test

include Rack::Test::Methods