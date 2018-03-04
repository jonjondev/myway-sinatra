# Module for authentication helper methods
module AuthenticationHelper

	def logged_in?
		!session[:email].nil?
	end

  def current_user
  	User.first(email: session[:email])
  end

  def authenticate
  	redirect "/login" if !logged_in?
  end

end