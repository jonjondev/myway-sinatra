class User
	include BaseModelProperties
  
  # Custom fields
  property :first_name, String
  property :last_name, String
  property :email, String
  property :password_hash, BCryptHash

  # Object methods
  def full_name
    "#{first_name} #{last_name}"
  end

end