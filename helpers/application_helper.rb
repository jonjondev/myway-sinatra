# frozen_string_literal: true

# Module for application-wide helper methods (however helpers are global anyway)
module ApplicationHelper
  def fetch_param(default, param_name)
    params[param_name.to_sym] || default
  end

  def application_test
    'this is text from the application helper'
  end
end
