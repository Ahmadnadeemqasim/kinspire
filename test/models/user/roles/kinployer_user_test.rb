require 'test_helper'

class KinployerUserTest < ActiveSupport::TestCase

  def setup
    @kinployer_user = users( :valid_kinployer_user )
  end

  ##
  # Kinployer.

  test "destroying the User should destroy the associated Kinployer" do
    assert_difference "Kinployer.count", -1, "Destroying a kinployer User should destroy the associated Kinployer." do
      @kinployer_user.destroy
    end
  end
end