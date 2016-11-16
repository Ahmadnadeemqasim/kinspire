##
# Facilitate simulating secure authentication in tests.

require 'crypto'

module TestUserAccountSecurityHelper
  
  ##
  # Return a secure digest of the given password.

  def password_digest( password )
    Crypto.secure_digest( password )
  end

  ##
  # Return the standard password.
  
  def standard_password
    "!@Cd5678"
  end

  ##
  # Return a secure digest of the standard password.

  def standard_password_digest
    password_digest( default_password )
  end
end