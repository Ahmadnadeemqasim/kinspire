class User < ApplicationRecord
  include User::DatabaseAuthenticatable
  include User::Rememberable
  include User::Roles

  before_save { email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@([a-z\d\-]+\.)+[a-z]+\z/i
  validates :email,     presence: true,
                        length: { maximum: 255 },
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
  validates :password,  presence: true,
                        length: { minimum: 8 },
                        allow_nil: true
end
