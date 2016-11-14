##
# Facilitate simulating secure passwords in tests.

require 'crypto'

module TestPasswordHelper
  
  ##
  # Return the hash digest of the given string.

  def password_digest( string )
    Crypto.secure_digest( string )
  end

  ##
  # Return the standard password.
  
  def standard_password
    "!@Cd5678"
  end

  ##
  # Return the hash digest of the standard password.

  def standard_password_digest
    password_digest( default_password )
  end
end