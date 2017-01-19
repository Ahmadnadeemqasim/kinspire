require 'test_helper'

class KinployerValidationTest < ActiveSupport::TestCase

  def setup
    @kinployer = kinployers( :valid_kinployer )
  end

  ##
  # Test object failsafes.

  test "valid Kinployer must be valid" do
    assert_equal Kinployer, @kinployer.class, "Testing against wrong class!"
    assert @kinployer.valid?,
      "\n" +
      "Kinployer test object is not valid.\n" +
      "These tests must be run against an object that is valid by default.\n" +
      "Validation failed with errors:\n" +
      "#{@kinployer.errors.full_messages}\n\n"
  end

  ##
  # User association.

  test "User must be present" do
    @kinployer.user = nil
    assert_not @kinployer.valid?, "Associated User must be required."
  end

  test "User must be unique" do
    assert @kinployer.save
    new_kinployer = @kinployer.dup
    assert_not new_kinployer.valid?,                      "Associated User must be unique."
    assert new_kinployer.errors.added?( :user, :taken )
  end
end