require 'crypto'

class User
  attr_accessor :remember_login_token # user login persistence

  ##
  # Authenticate the user remembered login against the given token.

  def authenticate_remember_login_token( remember_login_token )
    return false if remember_login_digest.nil?
    BCrypt::Password.new( remember_login_digest ).is_password?( remember_login_token )
  end

  ##
  # Clear the digest that remembers user login.

  def forget_login
    update_attribute :remember_login_digest, nil
  end

  ##
  # Update token and digest for remembering user login.

  def remember_login
    self.remember_login_token = User.new_token
    update_attribute :remember_login_digest, Crypto.secure_digest( remember_login_token )
  end

  ##
  # Generate a randomized secure token suitable for user authentication purposes.

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  module Rememberable
  end
end