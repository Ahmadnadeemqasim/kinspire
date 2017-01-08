require 'test_helper'

class KinployeeUserValidationTest < ActiveSupport::TestCase

  def setup
    @kinployee_user = users( :valid_kinployee_user )
  end

  ##
  # Test object failsafes.

  test "valid Kinployee User must be valid" do
    assert @kinployee_user.is_kinployee?, "Kinployee user has wrong role."
    assert @kinployee_user.valid?,
      "\n" +
      "Kinployee User test object is not valid.\n" +
      "These tests must be run against an object that is valid by default.\n" +
      "Validation failed with errors:\n" +
      "#{@kinployee_user.errors.full_messages}\n\n"
  end

  ##
  # Association constraints.

  test "associated Kinployee should be required" do
    @kinployee_user.kinployee = nil
    assert_not @kinployee_user.valid?, "Associated Kinployee should be required."
  end

  test "associated Kinployee must be valid" do
    # Duplicate Kinployee should be invalid due to User unique constraint.
    duplicate_kinployee = kinployees( :valid_kinployee ).dup
    duplicate_kinployee.user = @kinployee_user
    
    assert_not @kinployee_user.kinployee.valid?,  "Associated Kinployee should not be valid."
    assert_not @kinployee_user.valid?,            "Kinployee user should require a valid Kinployee."
    assert @kinployee_user.errors.added?( :kinployee, :invalid ),
                                                  "Correct error should have been added."
  end

  test "must not have an associated Kinployer" do
    @kinployee_user.kinployer = Kinployer.new
    assert_not @kinployee_user.valid?, "Associated Kinployer should not be allowed."
  end
end