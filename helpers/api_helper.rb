# Module for api-wide helper methods (however helpers are global anyway)
module ApiHelper

	# Fetches a parameter from params if it exists, otherwise it looks
	# for its value in the corresponding model.
	def get_param object, param_name
		params[param_name.to_sym] ? params[param_name.to_sym] : object[param_name]
	end

  def api_test
    "this is text from the api helper"
  end

end