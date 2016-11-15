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
  # logged_in?

  test "function logged_in? should return true if a user is currently logged in, false otherwise" do
    assert_nil session[:user_account_id]
    assert_not logged_in?,  "Function incorrectly indicates that a user is logged in."
    log_in( @user_account )
    assert logged_in?,      "Function incorrectly indicates that no user is logged in."
  end
end