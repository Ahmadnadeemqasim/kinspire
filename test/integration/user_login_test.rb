require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user_account = user_accounts( :vader )
    @password     = "imURfatha!"
  end

  test "user submits invalid credentials at log in" do
    get login_path
    assert_not is_logged_in?,       "No user should be logged in by default."

    post login_path, params: { session: { email: "", password: "" } }
    assert_response :success,       "Invalid login submission should generate an HTTP SUCCESS response."
    assert_not is_logged_in?,       "Invalid login submission should not log any user in."
    assert_template 'sessions/new', "Log in page should be rerendered after invalid login attempt."
  end

  test "user submits valid credentials at login and then logs out" do
    get login_path
    assert_not is_logged_in?,       "No user should be logged in by default."

    post login_path, params: { session: { email: @user_account.email, password: @password } }
    assert is_logged_in?,                 "Successful login should log the user in immediately."
    assert_redirected_to @user_account,   "Successful login should redirect to the user's account homepage."
    follow_redirect!
    assert_template 'user_accounts/show', "Successful login should render the user's show page."

    delete logout_path
    assert_not is_logged_in?,                 "Visiting the logout path should log the user out immediately."
    assert_redirected_to root_url,            "Visiting the logout path should redirect to the application homepage."
    follow_redirect!
    assert_template 'static_pages/homepage',  "Visiting the logout path should render the application homepage."
  end

  test "user submits valid credentials in two browsers and then logs out from both browsers" do
    get login_path
    assert_not is_logged_in?, "No user should be logged in by default."

    post login_path, params: { session: { email: @user_account.email, password: @password } }
    assert is_logged_in?,     "Successful login should log the user in immediately."
    follow_redirect!

    post login_path, params: { session: { email: @user_account.email, password: @password } }
    assert is_logged_in?,     "Successful login should log the user in immediately."
    follow_redirect!

    delete logout_path
    assert_not is_logged_in?, "Visiting the logout path should log the user out immediately."
    follow_redirect!

    delete logout_path
    follow_redirect!
  end

  test "email is not case-sensitive at login" do
    lowercase_email = @user_account.email.downcase
    uppercase_email = @user_account.email.upcase

    get login_path
    assert_not is_logged_in?

    post login_path, params: { session: { email: lowercase_email, password: @password } }
    assert is_logged_in?,       "Login should be successful with lowercase email."

    delete logout_path
    assert_not is_logged_in?,   "Visiting the logout path should log the user out immediately."

    post login_path, params: { session: { email: uppercase_email, password: @password } }
    assert is_logged_in?,       "Login should be successful with uppercase email."
  end

  test "login with remembering" do
    log_in_as( @user_account, password: @password, remember_login: '1' )
    assert_equal  cookies['remember_login_token'], assigns( :user_account ).remember_login_token,
                  "User login not remembered when it should be."
  end

  test "login without remembering" do
    log_in_as( @user_account, password: @password, remember_login: '0' )
    assert_nil cookies['remember_login_token'], "User login remembered when it should not be."
  end
end
