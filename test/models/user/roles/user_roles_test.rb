require 'test_helper'

class UserRolesTest < ActiveSupport::TestCase

  ##
  # #is_admin?

  test "method #is_admin? must return true if user has admin role, false otherwise" do
    admin_user      = User.new( role: 'admin' )
    non_admin_user  = User.new( role: 'kinployee' )

    assert      admin_user.is_admin?
    assert_not  non_admin_user.is_admin?
  end

  ##
  # #is_kinployee?

  test "method #is_kinployee? must return true if user has kinployee role, false otherwise" do
    kinployee_user     = User.new( role: 'kinployee' )
    non_kinployee_user = User.new( role: 'admin' )

    assert      kinployee_user.is_kinployee?
    assert_not  non_kinployee_user.is_kinployee?
  end

  ##
  # #is_kinployer?

  test "method #is_kinployer? must return true if user has kinployer role, false otherwise" do
    kinployer_user     = User.new( role: 'kinployer' )
    non_kinployer_user = User.new( role: 'admin' )

    assert      kinployer_user.is_kinployer?
    assert_not  non_kinployer_user.is_kinployer?
  end
end