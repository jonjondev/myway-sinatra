# A controller for the example module
class ExampleController < ApplicationController
	helpers ExampleHelper

	# Displays example.rb at localhost:9292/example
  get '/' do
	  erb :example
	end
end