# frozen_string_literal: true

# Put all application requirements here
require 'rubygems'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'
require 'bcrypt'
require 'json'
require 'pry'

# Sets Puma as default server
configure do
  set :server, :puma
end

# Requires base api files
require File.expand_path(File.join('helpers', 'auth_helper'))
require File.expand_path(File.join('helpers', 'api_helper'))
require File.expand_path(File.join('api', 'base_api'))
require File.expand_path(File.join('api', %w[auth sessions_api]))

# Requires other ruby files
Dir[File.join('helpers', '**/*_helper.rb')].each do |file|
  require File.expand_path(file)
end

Dir[File.join('api', 'v1', '**/*_api.rb')].each do |file|
  require File.expand_path(file)
end

# Requires model files
require File.expand_path(File.join('config', 'models'))
