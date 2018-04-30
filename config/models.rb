# Require the DataMapper components
require 'data_mapper'
require 'dm-core'
require 'dm-timestamps'

# Require the models
require File.expand_path(File.join('models', 'base_model_properties'))
Dir[File.join('models', '**/*_model.rb')].each { |file| require File.expand_path(file) }

def try_import name
	begin
	  require name 
	rescue Error
	  print "Import Error: #{name} not found, add to Gemfile."
	end
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
  DataMapper.setup(:default, 'postgres://username:password@hostname/database')
end
# :nocov:

DataMapper.finalize
DataMapper.auto_upgrade!