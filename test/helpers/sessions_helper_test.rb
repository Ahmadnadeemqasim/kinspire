class SessionsHelperTest < ActionView::TestCase
  include SessionsHelper

  def setup
    @user = users( :vader )
  end

  ##
  # #current_user

  test "function current_user should return the currently logged-in user if any" do
    assert_nil session[:user_id]
    assert_nil current_user
    log_in( @user )
    assert_equal current_user, @user, "Function does not return the currently logged-in user."
  end

  test "function current_user should return the remembered user if it exists and no user is logged in" do
    assert_nil current_user
    remember_login( @user )
    assert_nil session[:user_id]
    assert_equal current_user, @user, "Function does not return the remembered user."
  end

  test "function current_user should log in the remembered user if it exists and no user is logged in" do
    assert_nil current_user
    remember_login( @user )
    current_user
    assert is_logged_in?
  end

  test "function current_user should return nil if the remember login digest is wrong" do
    assert_nil current_user
    remember_login( @user )
    @user.update_attribute( :remember_login_digest, random_token_digest )
    assert_nil current_user, "Returned user when nil was expected."
  end

  ##
  # #forget_login

  test "function forget_login should forget the given user's login and clear the remember token and user id cookies" do
    remember_login( @user )
    @user.reload
    forget_login( @user )
    assert_nil @user.remember_login_digest,     "User did not forget login digest."
    assert_nil cookies[:remember_login_token],  "Remember login token was not cleared from cookies."
    assert_nil cookies[:user_id],               "User id was not cleared from cookies."
  end

  ##
  # #log_in

  test "function log_in should create a session for the given user and log it in" do
    assert_nil session[:user_id]
    log_in( @user )
    assert_equal session[:user_id], @user.id, "User login does not populate session hash with correct value."
  end

  ##
  # #log_out

  test "function log_out should destroy the current user session and clear the current user" do
    log_in( @user )
    assert_equal current_user, @user
    log_out
    assert_nil session[:user_id], "Log out did not remove the current user from the session hash."
    assert_nil current_user,      "Log out did not remove the current user."
  end

  test "function log_out should forget the rememebered user" do
    remember_login( @user )
    assert_equal @user, current_user
    log_out
    assert_nil current_user, "Log out did not forget the remembered user."
  end

  ##
  # #logged_in?

  test "function logged_in? should return true if a user is currently logged in, false otherwise" do
    assert_nil session[:user_id]
    assert_not logged_in?,  "Function incorrectly indicates that a user is logged in."
    log_in( @user )
    assert logged_in?,      "Function incorrectly indicates that no user is logged in."
  end

  ##
  # #remember_login

  test "function remember_login should create cookies for remember token and signed user id" do
    assert_nil @user.remember_login_token
    assert_nil cookies[:remember_login_token]
    assert_nil cookies[:user_id]
    remember_login( @user )
    assert_not_nil @user.remember_login_token,
      "User remember_login_token was not generated."
    assert_not_nil @user.remember_login_digest,
      "User remember_login_digest was not generated."
    assert_equal  @user.remember_login_token, cookies[:remember_login_token],
      "Remember user login does not populate cookies hash with remember token."
    assert_equal  @user.id,                   cookies.signed[:user_id],
      "Remember user login does not populate cookies hash with user id."
  end
end