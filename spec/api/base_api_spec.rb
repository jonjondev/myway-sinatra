# frozen_string_literal: true

# Requires the spec_helper containing code to set up testing
require File.expand_path(File.join('helpers', 'spec_helper'))

# Test for base api routes
describe 'BaseApi' do
  # Defines app as base api
  def app
    BaseApi
  end

  it 'routes to the index' do
    get '/'
    expect(last_response).to be_ok
  end

  # bad route
  include_examples 'bad route example'
end
