# frozen_string_literal: true

# A user class that inherits properties from the base model
class User
  include BaseModelProperties

  # Custom fields
  property :first_name, String, required: true
  property :last_name, String, required: true
  property :email, String, required: true, unique: true
  property :password_hash, BCryptHash, required: true

  # Object methods
  def full_name
    "#{first_name} #{last_name}"
  end
end
