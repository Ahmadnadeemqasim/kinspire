require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new at the signup path" do
    get signup_path
    assert_response :success, "Visit signup path unsucessful."
  end

end
