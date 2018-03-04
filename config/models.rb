# Require the DataMapper components
require 'data_mapper'
require 'dm-core'
require 'dm-timestamps'
require 'dm-postgres-adapter'
require 'dm-sqlite-adapter'

# Require the models
require File.expand_path(File.join('models', 'base_model_properties'))
Dir[File.join('models', '**/*_model.rb')].each { |file| require File.expand_path(file) }


# Configure database environment values for testing
configure :test do
  DataMapper.setup(:default, 'sqlite::memory:')
end

# :nocov:
# Configure database environment values for development
configure :development do
  DataMapper.setup(:default, 'postgres://myway:myway@localhost:5432/myway')
end

# Configure database environment values for production
configure :production do
  DataMapper.setup(:default, 'postgres://username:password@hostname/database')
end
# :nocov:

DataMapper.finalize
DataMapper.auto_upgrade!