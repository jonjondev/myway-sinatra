# frozen_string_literal: true

# Module for api-wide helper methods (however helpers are global anyway)
module ApiHelper
  def api_test
    'this is text from the api helper'
  end

  def error_response(message)
    halt 403, { result: 'error', message: message }.to_json
  end
end
