require 'test_helper'

class UserAccountTest < ActiveSupport::TestCase

  ##
  # #authentic_remember_login_token?

  test "method #authentic_remember_login_token? should return true if the \
        given token matches the associated digest" do
    user_account = user_accounts( :vader )
    user_account.remember_login
    assert  user_account.authentic_remember_login_token?( user_account.remember_login_token ),
            "Authentication failed when it should have succeeded."
  end

  test "method #authentic_remember_login_token? should return false if the \
        given token does not match the associated digest" do
    user_account = user_accounts( :vader )
    user_account.remember_login
    assert_not  user_account.authentic_remember_login_token?( random_token ),
                "Authentication succeeded when it should have failed."
  end

  ##
  # #remember_login

  test "method #remember_login should update the account's remember_login_token and remember_login_digest" do
    user_account = user_accounts( :vader )
    assert_nil user_account.remember_login_token
    assert_nil user_account.remember_login_digest
    user_account.remember_login
    user_account.reload           # Ensure changes to the database are tested.
    assert_not_nil user_account.remember_login_token,   "remember_login_token was not updated"
    assert_not_nil user_account.remember_login_digest,  "remember_login_digest was not updated"
  end

  ##
  # .new_token

  test "function .new_token should generate a token of the correct length" do
    assert_equal 22, UserAccount.new_token.length, "Token is not the expected length."
  end

  test "function .new_token should generate tokens randomly" do
    token1 = UserAccount.new_token
    token2 = UserAccount.new_token
    assert_not_equal token1, token2, "Tokens are not randomized."
  end
end