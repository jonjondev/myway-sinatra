# Put all requirements here
require 'rubygems'
require 'sinatra'
require 'sinatra/base'

# Requires application files
require File.expand_path(File.join('helpers', 'application_helper'))
require File.expand_path(File.join('controllers', 'application_controller'))

# Requires other ruby files
Dir[File.join('helpers', '**/*_helper.rb')].each { |file| require File.expand_path(file) }
Dir[File.join('controllers', '**/*_controller.rb')].each { |file| require File.expand_path(file) }