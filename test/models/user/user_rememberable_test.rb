require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = users( :vader )
  end

  ##
  # #authenticate_remember_login_token

  test "function authenticate_remember_login_token should return true if the \
        given token matches the associated digest" do
    @user.remember_login
    assert  @user.authenticate_remember_login_token( @user.remember_login_token ),
            "Authentication failed when it should have succeeded."
  end

  test "function authenticate_remember_login_token should return false if the \
        given token does not match the associated digest" do
    @user.remember_login
    assert_not  @user.authenticate_remember_login_token( ' ' ),
                "Authentication succeeded when it should have failed."
  end

  test "function authentic_remember_login_token should return false if the \
        remember_login_digest is nil" do
    assert_nil  @user.remember_login_digest
    assert_not  @user.authenticate_remember_login_token( ' ' ),
                "Authenticating against a nil remember_login_digest should return false."
  end

  ##
  # #forget_login

  test "function forget_login should clear the user's remember_login_digest" do
    @user.remember_login
    @user.reload
    @user.forget_login
    assert_nil @user.remember_login_digest, "remember_login_digest was not cleared."
  end

  ##
  # #remember_login

  test "function remember_login should update the user's remember_login_token and remember_login_digest" do
    assert_nil @user.remember_login_token
    assert_nil @user.remember_login_digest
    @user.remember_login
    @user.reload           # Ensure changes to the database are tested.
    assert_not_nil @user.remember_login_token,   "remember_login_token was not updated."
    assert_not_nil @user.remember_login_digest,  "remember_login_digest was not updated."
  end

  ##
  # .new_token

  test "function .new_token should generate a token of the correct length" do
    assert_equal 22, User.new_token.length, "Token is not the expected length."
  end

  test "function .new_token should generate tokens randomly" do
    token1 = User.new_token
    token2 = User.new_token
    assert_not_equal token1, token2, "Tokens are not randomized."
  end
  
end