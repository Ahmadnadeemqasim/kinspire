require 'test_helper'

class UserAccountValidationTest < ActiveSupport::TestCase

  def setup
    @user_account = UserAccount.new(  email: "masterchief@unsc.mil",
                                      password: standard_password, password_confirmation: standard_password )
  end

  test "the test user should be valid by default" do
    assert @user_account.valid?, "UserAccount test object is not valid. These tests must be run against an object that is valid by default."
  end

  ##
  # Email

  test "email should be required" do
    @user_account.email = ""
    assert_not @user_account.valid?, "Blank UserAccount email should not be valid."
  end

  test "email should be limited to a reasonable length" do
    # Length limit is 255.

    valid_email = "a" * 244 + "@empire.gov"
    @user_account.email = valid_email
    assert @user_account.valid?

    invalid_email = "a" * 245 + "@empire.gov"
    @user_account.email = invalid_email
    assert_not @user_account.valid?, "UserAccount email over a reasonable maximum length should not be valid."
  end

  test "email should be required to match a basic email format" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user_account.email = valid_address
      assert @user_account.valid?, "#{valid_address.inspect} should be a valid email address for UserAccount."
    end

    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com user@example..com]
    invalid_addresses.each do |invalid_address|
      @user_account.email = invalid_address
      assert_not @user_account.valid?, "#{invalid_address.inspect} should not be a valid email address for UserAccount."
    end
  end

  test "email should be required to be unique" do
    duplicate_user_account = @user_account.dup
    duplicate_user_account.email = @user_account.email.upcase # uniqueness validation should be case-insensitive
    @user_account.save
    assert_not duplicate_user_account.valid?, "Duplicate UserAccount email should not be valid."
  end

  test "email should be saved in lower case" do     # NOTE: This is technically not a validation test. Is this the right place for this test?
    mixed_case_email = "FaThEr@SkYwAlKeR.cOm"
    @user_account.email = mixed_case_email
    @user_account.save
    assert_equal mixed_case_email.downcase, @user_account.reload.email, "UserAccount email should be saved in lower case."
  end

  ##
  # Password

  test "password should be required present and not blank" do
    @user_account.password = @user_account.password_confirmation = " " * 10
    assert_not @user_account.valid?, "New UserAccount without a password should not be valid."
  end

  test "password and password_confirmation should be required to match" do
    valid_password = standard_password
    @user_account.password = @user_account.password_confirmation = valid_password
    assert @user_account.valid?
    @user_account.password_confirmation = valid_password + "a"
    assert_not @user_account.valid?, "New UserAccount should not be valid when password_confirmation does not match password."
  end

  test "password should have a minimum length" do
    min_length = 8

    valid_password = standard_password[0, min_length]
    @user_account.password = @user_account.password_confirmation = valid_password
    assert @user_account.valid?

    invalid_password = valid_password[0, min_length-1]
    @user_account.password = @user_account.password_confirmation = invalid_password
    assert_not @user_account.valid?, "New UserAccount with password under the minimum length should not be valid."
  end

  test "password should not be required for an existing record" do
    @user_account.save
    existing_user_account = UserAccount.find( @user_account.id )
    assert_equal nil, existing_user_account.password
    assert existing_user_account.valid?, "Existing UserAccounts should not require a password to be valid."
  end
end
