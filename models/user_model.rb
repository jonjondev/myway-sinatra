class User
	include DataMapper::Resource

	# Basic fields
	property :id, Serial
  
  # Custom fields
  property :first_name, String
  property :last_name, String
  property :email, String
  property :salt, String
  property :password_hash, String

  # Object methods
  def full_name
    "#{first_name} #{last_name}"
  end

end

DataMapper.finalize