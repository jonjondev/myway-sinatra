# A controller for the example module
class ExampleController < ApplicationController
	helpers ExampleHelper

	# Displays example.rb at localhost:3000/example
  get '/' do
	  erb :'example/example'
	end
end