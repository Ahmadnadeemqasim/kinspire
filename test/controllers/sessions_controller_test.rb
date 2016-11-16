require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
  test "should get new at login path" do
    get login_path
    assert_response :success,       "Visit login path unsucessful."
    assert_template 'sessions/new', "Visit login path should render sessions new page."
  end

end
