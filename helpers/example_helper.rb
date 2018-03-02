# Module for module-specific helper methods (however helpers are global anyway)
module ExampleHelper

  def example_test
  	user_full_name = User.first(:id).full_name

  	if user_full_name != nil
  		user_full_name
  	end
  end

end