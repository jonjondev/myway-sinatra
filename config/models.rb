# frozen_string_literal: true

# Require the DataMapper components
require 'data_mapper'
require 'dm-core'
require 'dm-timestamps'

# Require the models
require File.expand_path(File.join('models', 'base_model_properties'))
Dir[File.join('models', '**/*.rb')].each do |file|
  require File.expand_path(file)
end

def try_import(name)
  require name
rescue LoadError
  # :nocov:
  print "Import Error: #{name} not found, add to Gemfile."
  # :nocov:
end

# Configure database environment values for testing
configure :test do
  try_import('dm-sqlite-adapter')
  DataMapper.setup(:default, 'sqlite::memory:')
end

# :nocov:
# Configure database environment values for development
configure :development do
  try_import('dm-postgres-adapter')
  DataMapper.setup(:default, 'postgres://myway:myway@localhost:5432/myway')
end

# Configure database environment values for production
configure :production do
  DataMapper.setup(:default, ENV['DATABASE_URL'])
end
# :nocov:

DataMapper.finalize
DataMapper.auto_upgrade!
