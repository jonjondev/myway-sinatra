# frozen_string_literal: true

# Module for application-wide helper methods (however helpers are global anyway)
module ApplicationHelper
  def get_param(object, param_name)
    params[param_name.to_sym] ? params[param_name.to_sym] : object[param_name]
  end

  def application_test
    'this is text from the application helper'
  end
end
