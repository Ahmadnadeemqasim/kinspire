require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
  test "should get login at login path" do
    get login_path
    assert_response :success,         "Visit login path unsucessful."
    assert_template 'sessions/login', "Visit login path should render login page."
  end

end
