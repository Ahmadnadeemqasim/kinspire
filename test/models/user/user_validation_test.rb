require 'test_helper'

class UserValidationTest < ActiveSupport::TestCase

  def setup
    @user = User.new( email: "masterchief@unsc.mil",
                      password: standard_password, password_confirmation: standard_password,
                      role: 'admin' )
  end

  ##
  # Test object failsafe.

  test "the test user should be valid by default" do
    assert @user.valid?, "User test object is not valid. These tests must be run against an object that is valid by default."
  end

  ##
  # Email

  test "email should be required" do
    @user.email = ""
    assert_not @user.valid?, "Blank User email should not be valid."
  end

  test "email should be limited to a reasonable length" do
    # Length limit is 255.

    valid_email = "a" * 244 + "@empire.gov"
    @user.email = valid_email
    assert @user.valid?

    invalid_email = "a" * 245 + "@empire.gov"
    @user.email = invalid_email
    assert_not @user.valid?, "User email over a reasonable maximum length should not be valid."
  end

  test "email should be required to match a basic email format" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be a valid email address for User."
    end

    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com user@example..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should not be a valid email address for User."
    end
  end

  test "email should be required to be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase # uniqueness validation should be case-insensitive
    @user.save
    assert_not duplicate_user.valid?, "Duplicate User email should not be valid."
  end

  ##
  # Password

  test "password should be required present and not blank" do
    @user.password = @user.password_confirmation = " " * 10
    assert_not @user.valid?, "New User without a password should not be valid."
  end

  test "password and password_confirmation should be required to match" do
    valid_password = standard_password
    @user.password = @user.password_confirmation = valid_password
    assert @user.valid?
    @user.password_confirmation = valid_password + "a"
    assert_not @user.valid?, "New User should not be valid when password_confirmation does not match password."
  end

  test "password should have a minimum length" do
    min_length = 8

    valid_password = standard_password[0, min_length]
    @user.password = @user.password_confirmation = valid_password
    assert @user.valid?

    invalid_password = valid_password[0, min_length-1]
    @user.password = @user.password_confirmation = invalid_password
    assert_not @user.valid?, "New User with password under the minimum length should not be valid."
  end

  test "password should not be required for an existing record" do
    @user.save
    existing_user = User.find( @user.id )
    assert_equal nil, existing_user.password
    assert existing_user.valid?, "Existing Users should not require a password to be valid."
  end

  ##
  # Role

  test "role should be required" do
    @user.role = nil

    assert_not @user.valid?, "Blank User role should not be valid."
  end

  test "role must be invalid if it is not one of the defined roles" do
    defined_roles = User::ROLES
    role = 'invalid'
    @user.role = role

    assert_not defined_roles.include?( role )
    assert_not @user.valid?, "User with non-defined role should not be valid."
  end
end
