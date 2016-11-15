class UserAccount < ApplicationRecord
  attr_accessor :remember_login_token # user login persistence
  before_save { email.downcase! }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@([a-z\d\-]+\.)+[a-z]+\z/i
  validates :email,     presence: true,
                        length: { maximum: 255 },
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password,  presence: true,
                        length: { minimum: 8 },
                        allow_nil: true

  ##
  # Authenticate the user account remembered login against the given token.

  def authentic_remember_login_token?( remember_login_token )
    BCrypt::Password.new( remember_login_digest ).is_password?( remember_login_token )
  end

  ##
  # Update token and digest for remembering account login.

  def remember_login
    self.remember_login_token = UserAccount.new_token
    update_attribute :remember_login_digest, Crypto.secure_digest( remember_login_token )
  end

  ##
  # Generate a randomized secure token suitable for account authentication purposes.

  def UserAccount.new_token
    SecureRandom.urlsafe_base64
  end
end
