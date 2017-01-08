require 'test_helper'

class AdminUserValidationTest < ActiveSupport::TestCase

  def setup
    @admin_user = users( :valid_admin_user )
  end

  ##
  # Test object failsafes.

  test "valid Admin User must be valid" do
    assert @admin_user.is_admin?, "Admin user has wrong role."
    assert @admin_user.valid?,
      "\n" +
      "Admin User test object is not valid.\n" +
      "These tests must be run against an object that is valid by default.\n" +
      "Validation failed with errors:\n" +
      "#{@admin_user.errors.full_messages}\n\n"
  end

  ##
  # Association constraints.

  test "must not have an associated Kinployer" do
    @admin_user.kinployer = Kinployer.new
    assert_not @admin_user.valid?, "Associated Kinployer should not be allowed."
  end

  test "must not have an associated Kinployee" do
    @admin_user.kinployee = Kinployee.new
    assert_not @admin_user.valid?, "Associated Kinployee should not be allowed."
  end
end


