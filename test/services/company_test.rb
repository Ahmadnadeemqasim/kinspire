require 'test_helper'

class CompanyTest < ActiveSupport::TestCase

  ##
  # .string

  test "function .string should accept a symbol and return a string" do
    assert_equal "Kinspire", Company.string( :company_name ), "Function does not behave as expected."
  end
end
