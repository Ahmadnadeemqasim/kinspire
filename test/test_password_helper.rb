module TestPasswordHelper
  ##
  # Facilitate simulating secure passwords in tests.
  
  ##
  # Return the hash digest of the given string.

  def password_digest( string )
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
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