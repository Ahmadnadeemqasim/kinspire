module TestPasswordHelper
  ##
  # Facilitate simulating secure passwords in tests.
  
  ##
  # Returns the hash digest of the given string.

  def password_digest( string )
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end