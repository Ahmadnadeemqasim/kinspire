class SessionsHelperTest < ActionView::TestCase
  include SessionsHelper

  def setup
    @user_account = user_accounts( :vader )
  end

  ##
  # #current_user

  test "function current_user_account should return the currently logged-in user if any" do
    assert_nil session[:user_account_id]
    assert_nil current_user_account
    log_in( @user_account )
    assert_equal current_user_account, @user_account, "Function does not return the currently logged-in user."
  end

  test "function current_user_account should return the remembered user if it exists and no user account is logged in" do
    assert_nil current_user_account
    remember_login( @user_account )
    assert_nil session[:user_account_id]
    assert_equal current_user_account, @user_account, "Function does not return the remembered user."
  end

  test "function current_user_account should log in the remembered user if it exists and no user account is logged in" do
    assert_nil current_user_account
    remember_login( @user_account )
    current_user_account
    assert is_logged_in?
  end

  test "function current_user_account should return nil if the remember login digest is wrong" do
    assert_nil current_user_account
    remember_login( @user_account )
    @user_account.update_attribute( :remember_login_digest, random_token_digest )
    assert_nil current_user_account, "Returned user when nil was expected."
  end

  ##
  # #forget_login

  test "function forget_login should forget the given user's login and clear the remember token and account id cookies" do
    remember_login( @user_account )
    @user_account.reload
    forget_login( @user_account )
    assert_nil @user_account.remember_login_digest, "User account did not forget login digest."
    assert_nil cookies[:remember_login_token],      "Remember login token was not cleared from cookies."
    assert_nil cookies[:user_account_id],           "User account id was not cleared from cookies."
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

  test "function log_out should forget the rememebered user" do
    remember_login( @user_account )
    assert_equal @user_account, current_user_account
    log_out
    assert_nil current_user_account, "Log out did not forget the remembered user."
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
    assert_not_nil @user_account.remember_login_digest,
      "UserAccount remember_login_digest was not generated."
    assert_equal  @user_account.remember_login_token, cookies[:remember_login_token],
      "Remember user login does not populate cookies hash with remember token."
    assert_equal  @user_account.id,                   cookies.signed[:user_account_id],
      "Remember user login does not populate cookies hash with user account id."
  end
end