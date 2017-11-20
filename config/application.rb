# Put all requirements here
require 'rubygems'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'
require 'json'

# Sets Puma as default server
configure { set :server, :puma }

# Requires application files
require File.expand_path(File.join('helpers', 'application_helper'))
require File.expand_path(File.join('controllers', 'application_controller'))

# Requires api files
require File.expand_path(File.join('helpers', 'api_helper'))
require File.expand_path(File.join('api', 'v1','base_api'))

# Requires other ruby files
Dir[File.join('helpers', '**/*_helper.rb')].each { |file| require File.expand_path(file) }
Dir[File.join('controllers', '**/*_controller.rb')].each { |file| require File.expand_path(file) }
Dir[File.join('api', 'v1','**/*_api.rb')].each { |file| require File.expand_path(file) }