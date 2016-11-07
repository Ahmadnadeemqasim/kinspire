require 'test_helper'

class CompanyTest < ActiveSupport::TestCase

  ##
  # .strings

  test "function .strings should behave as a hash and return the expected value" do
    assert_equal "Kinspire", Company.strings[:company_name]
  end
end
