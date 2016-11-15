class SessionsHelperTest < ActionView::TestCase
  include SessionsHelper

  def setup
    @user_account = user_accounts( :vader )
  end

  ##
  # #current_user

  test "function current_user_account should return the currently logged-in user if any, otherwise nil" do
    assert_nil session[:user_account_id]
    assert_nil current_user_account
    log_in( @user_account )
    assert_equal current_user_account, @user_account, "Function does not return the currently logged-in user."
  end

  ##
  # #log_in

  test "function log_in should create a session for the given user account and log it in" do
    assert_nil session[:user_account_id]
    log_in( @user_account )
    assert_equal session[:user_account_id], @user_account.id, "User login does not populate session hash with correct value."
  end

  ##
  # #log_out

  test "function log_out should destroy the current user account session and clear the current user" do
    log_in( @user_account )
    assert_equal current_user_account, @user_account
    log_out
    assert_nil session[:user_account_id], "Log out did not remove the current user account from the session hash."
    assert_nil current_user_account,      "Log out did not remove the current user account."
  end

  ##
  # #logged_in?

  test "function logged_in? should return true if a user is currently logged in, false otherwise" do
    assert_nil session[:user_account_id]
    assert_not logged_in?,  "Function incorrectly indicates that a user is logged in."
    log_in( @user_account )
    assert logged_in?,      "Function incorrectly indicates that no user is logged in."
  end

  ##
  # #remember_login

  test "function remember_login should create cookies for remember token and signed user account id" do
    assert_nil @user_account.remember_login_token
    assert_nil cookies[:remember_login_token]
    assert_nil cookies[:user_account_id]
    remember_login( @user_account )
    assert_not_nil @user_account.remember_login_token,
      "UserAccount remember_login_token was not generated."
    assert_equal  @user_account.remember_login_token, cookies[:remember_login_token],
      "Remember user login does not populate cookies hash with remember token."
    assert_equal  @user_account.id,                   cookies.signed[:user_account_id],
      "Remember user login does not populate cookies hash with user account id."
  end
end