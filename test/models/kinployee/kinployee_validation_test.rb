require 'test_helper'

class KinployeeValidationTest < ActiveSupport::TestCase

  def setup
    @kinployee = kinployees( :valid_kinployee )
  end

  ##
  # Test object failsafes.

  test "valid Kinployee must be valid" do
    assert_equal Kinployee, @kinployee.class, "Testing against wrong class!"
    assert @kinployee.valid?,
      "\n" +
      "Kinployee test object is not valid.\n" +
      "These tests must be run against an object that is valid by default.\n" +
      "Validation failed with errors:\n" +
      "#{@kinployee.errors.full_messages}\n\n"
  end

  ##
  # User association.

  test "User must be present" do
    @kinployee.user = nil
    assert_not @kinployee.valid?, "Associated User must be required."
  end

  test "User must be unique" do
    assert @kinployee.save
    new_kinployee = @kinployee.dup
    assert_not new_kinployee.valid?,                      "Associated User must be unique."
    assert new_kinployee.errors.added?( :user, :taken )
  end
end