##
# General cryptographic functions.

module Crypto

  ##
  # Return the hash digest of the given string.
  # This function should be suitable for hashing secure passwords.

  def Crypto.secure_digest( string )
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create( string, cost: cost )
  end
end