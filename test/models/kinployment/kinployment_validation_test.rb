require 'test_helper'

class KinploymentValidationTest < ActiveSupport::TestCase

  def setup
    @kinployment = kinployments( :valid_kinployment )
  end

  ##
  # Test object failsafes.

  test "valid Kinployment must be valid" do
    assert_equal Kinployment, @kinployment.class, "Testing against wrong class!"
    assert @kinployment.valid?,
      "\n" +
      "Kinployment test object is not valid.\n" +
      "These tests must be run against an object that is valid by default.\n" +
      "Validation failed with errors:\n" +
      "#{@kinployment.errors.full_messages}\n\n"
  end

  ##
  # Kinployee association.

  test "Kinployee should not be required" do
    @kinployment.kinployee = nil
    assert @kinployment.valid?,
      "Kinployment should not require a Kinployee."
  end

  ##
  # Kinployer association.

  test "Kinployer should be required present and valid" do
    @kinployment.kinployer = nil
    assert_not @kinployment.valid?,
      "Kinployment should not be valid without a Kinployer."
  end
end
