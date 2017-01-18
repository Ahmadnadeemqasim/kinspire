require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "email should be saved in lower case" do
    mixed_case_email = "FaThEr@SkYwAlKeR.cOm"
    user = User.new(  email: mixed_case_email,
                      name: "John Smith",
                      password: standard_password, password_confirmation: standard_password,
                      role: 'admin' )
    user.save!
    assert_equal mixed_case_email.downcase, user.reload.email, "User email should be saved in lower case."
  end

end