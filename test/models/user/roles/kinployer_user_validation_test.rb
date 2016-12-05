require 'test_helper'

class KinployerUserValidationTest < ActiveSupport::TestCase

  def setup
    @kinployer_user = users( :valid_kinployer_user )
  end

  ##
  # Test object failsafes.

  test "valid Kinployer User must be valid" do
    assert @kinployer_user.kinployer?, "Kinployer user has wrong role."
    assert @kinployer_user.valid?,
      "\n" +
      "Kinployer User test object is not valid.\n" +
      "These tests must be run against an object that is valid by default.\n" +
      "Validation failed with errors:\n" +
      "#{@kinployer_user.errors.full_messages}\n\n"
  end

  ##
  # Association constraints.

  test "associated Kinployer should be required" do
    @kinployer_user.kinployer = nil
    assert_not @kinployer_user.valid?, "Associated Kinployer should be required."
  end

  test "associated Kinployer must be valid" do
    # Duplicate Kinployer should be invalid due to User unique constraint.
    duplicate_kinployer = kinployers( :valid_kinployer ).dup
    duplicate_kinployer.user = @kinployer_user
    
    assert_not @kinployer_user.kinployer.valid?,  "Associated Kinployer should not be valid."
    assert_not @kinployer_user.valid?,            "Kinployer user should require a valid Kinployer."
    assert @kinployer_user.errors.added?( :kinployer, :invalid ),
                                                  "Correct error should have been added."
  end

  test "must not have an associated Kinployee" do
    @kinployer_user.kinployee = Kinployee.new
    assert_not @kinployer_user.valid?, "Associated Kinployee should not be allowed."
  end
end