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

  test "email should be limited to a reasonable length" do
    # Length limit is 255.

    valid_email = "a" * 244 + "@empire.gov"
    @user_account.email = valid_email
    assert @user_account.valid?

    invalid_email = "a" * 245 + "@empire.gov"
    @user_account.email = invalid_email
    assert_not @user_account.valid?
  end

  test "email should be required to match a basic email format" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user_account.email = valid_address
      assert @user_account.valid?
    end

    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com user@example..com]
    invalid_addresses.each do |invalid_address|
      @user_account.email = invalid_address
      assert_not @user_account.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email should be unique" do
    duplicate_user_account = @user_account.dup
    duplicate_user_account.email = @user_account.email.upcase # uniqueness validation should be case-insensitive
    assert_not duplicate_user_account.valid?
  end

  test "email should be saved in lower case" do
    mixed_case_email = "FaThEr@SkYwAlKeR.cOm"
    @user_account.email = mixed_case_email
    @user_account.save
    assert_equal mixed_case_email.downcase, @user_account.reload.email
  end
end
