require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  test "user submits invalid credentials at log in" do
    get login_path
    assert_response :success,       "Visit login path unsucessful."
    assert_template 'sessions/new', "Visit login path should render sessions new page."

    post login_path, params: { session: { email: "", password: "" } }
    assert_response :success,       "Invalid login submission should generate an HTTP SUCCESS response."
    assert_not is_logged_in?,       "Invalid login submission should not log any user in."
    assert_template 'sessions/new', "Log in page should be rerendered after invalid login attempt."
  end

  test "user valid credentials at login and then logs out" do
    user_account = user_accounts( :vader )

    get login_path
    assert_response :success,       "Visit login path unsucessful."
    assert_template 'sessions/new', "Visit login path should render sessions new page."
    assert_not is_logged_in?,       "No user should be logged in by default."

    post login_path, params: { session: { email: user_account.email, password: "imURfatha!" } }
    assert is_logged_in?,                 "Successful login should log the user in immediately."
    assert_redirected_to user_account,    "Successful login should redirect to the user's account homepage."
    follow_redirect!
    assert_template 'user_accounts/show', "Successful login should render the user's show page."

    delete logout_path
    assert_not is_logged_in?,             "Visiting the logout path should log the user out immediately."
    assert_redirected_to root_url,        "Visiting the logout path should redirect to the application homepage."
    follow_redirect!
    assert_template 'static_pages/index', "Visiting the logout path should render the application homepage."
  end
end
