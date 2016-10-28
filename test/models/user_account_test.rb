require 'test_helper'

class UserAccountTest < ActiveSupport::TestCase

  def setup
    @user_account = user_accounts( :vader )
  end

  test "the test user should be valid by default" do
    assert @user_account.valid?
  end

  test "email should be required" do
    @user_account.email = ""
    assert_not @user_account.valid?
  end

  test "email should not be too long" do
    valid_email = "a" * 244 + "@empire.gov"
    invalid_email = "a" * 245 + "@empire.gov"

    @user_account.email = valid_email
    assert @user_account.valid?

    @user_account.email = invalid_email
    assert_not @user_account.valid?
  end
end
