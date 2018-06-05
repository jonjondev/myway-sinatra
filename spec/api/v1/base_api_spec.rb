# frozen_string_literal: true

# Requires the spec_helper containing code to set up testing
require File.expand_path(File.join('helpers', 'spec_helper'))

# Test for base api routes
describe 'BaseApi' do
  # Defines app as base api
  def app
    BaseApi
  end

  it 'routes to a 404' do
    get '/probablyanotfounderror'
    expect(last_response).not_to be_ok
  end
end
