##
# Facilitate simulating secure authentication in tests.

require 'crypto'

module TestUserSecurityHelper
  
  ##
  # Return a secure digest of the given password.

  def password_digest( password )
    Crypto.secure_digest( password )
  end

  ##
  # Return a random token.

  def random_token
    SecureRandom.urlsafe_base64
  end

  ##
  # Return a secure digest of a random token.
  
  def random_token_digest
    token_digest( random_token )
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

  ##
  # Return a secure digest of the given token.

  def token_digest( token )
    Crypto.secure_digest( token )
  end
end