module SessionsHelper

  ##
  # Return the currently logged-in user account, if any.
  # Return nil if no user is logged in.
  # In order to avoid hitting the database with every call, this method memoizes
  # the result to an instance variable.

  def current_user_account
    @current_user_account ||= UserAccount.find_by( id: session[:user_account_id] )
  end

  ##
  # Log in the given user account.

  def log_in( user_account )
    session[:user_account_id] = user_account.id
  end

  ##
  # Log out the current user.

  def log_out
    session.delete( :user_account_id )
    @current_user_account = nil
  end

  ##
  # Return true if the current user is logged in, false otherwise.

  def logged_in?
    !current_user_account.nil?
  end

  ##
  # Keeps the user logged in between sessions.

  def remember_login( user_account )
    user_account.remember_login
    cookies.permanent[:remember_login_token] = user_account.remember_login_token
    cookies.permanent.signed[:user_account_id] = user_account.id
  end
end
