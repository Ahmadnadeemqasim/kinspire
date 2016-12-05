require 'test_helper'

class KinployeeUserTest < ActiveSupport::TestCase

  def setup
    @kinployee_user = users( :valid_kinployee_user )
  end

  ##
  # Kinployee.

  test "destroying the User should destroy the associated Kinployee" do
    assert_difference "Kinployee.count", -1, "Destroying a kinployee User should destroy the associated Kinployee." do
      @kinployee_user.destroy
    end
  end
end