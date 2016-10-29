require 'test_helper'

class UserAccountValidationTest < ActiveSupport::TestCase

  def setup
    @user_account = UserAccount.new(  email: "masterchief@unsc.mil",
                                      password: "!@Cd5678", password_confirmation: "!@Cd5678" )
  end

  test "the test user should be valid by default" do
    assert @user_account.valid?, "#{self.class.name} test object is not valid. These tests must be run against an object that is valid by default."
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

  test "email should be required to be unique" do
    duplicate_user_account = @user_account.dup
    duplicate_user_account.email = @user_account.email.upcase # uniqueness validation should be case-insensitive
    @user_account.save
    assert_not duplicate_user_account.valid?, "#{@user_account.class.name} email should be required to be unique to be valid."
  end

  test "email should be saved in lower case" do
    mixed_case_email = "FaThEr@SkYwAlKeR.cOm"
    @user_account.email = mixed_case_email
    @user_account.save
    assert_equal mixed_case_email.downcase, @user_account.reload.email
  end

  test "password and password_confirmation should be required to match" do
    valid_password = "!@Cd5678"
    @user_account.password = @user_account.password_confirmation = valid_password
    assert @user_account.valid?
    @user_account.password_confirmation = valid_password + "a"
    assert_not @user_account.valid?
  end

  test "password should be required present and not blank" do
    @user_account.password = @user_account.password_confirmation = " " * 10
    assert_not @user_account.valid?, "New #{@user_account.class.name} should be required to have a nonblank password to be valid."
  end

  test "password should have a minimum length" do
    # Minimum length is 8.

    valid_password = "!@Cd5678"
    @user_account.password = @user_account.password_confirmation = valid_password
    assert @user_account.valid?

    invalid_password = "!@Cd567"
    @user_account.password = @user_account.password_confirmation = invalid_password
    assert_not @user_account.valid?, "New #{@user_account.class.name} should be required to have a password of a minimum length to be valid."
  end

  test "password should not be required for an existing record" do
    @user_account.save
    existing_user_account = UserAccount.find( @user_account.id )
    assert_equal nil, existing_user_account.password
    assert existing_user_account.valid?, "Existing #{@user_account.class.name}s should not require a password to be valid."
  end
end
