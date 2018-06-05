# frozen_string_literal: true

# Requires the spec_helper containing code to set up testing
require File.expand_path(File.join('helpers', 'spec_helper'))

# Test for application controller routes
describe 'ApplicationController' do
  # Defines app as the tested controller
  def app
    ApplicationController
  end

  it 'routes to home' do
    get '/'
    expect(last_response).to be_ok
  end

  it 'routes to a 404' do
    get '/probablyanotfounderror'
    expect(last_response).not_to be_ok
  end
end
