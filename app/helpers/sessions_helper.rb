module SessionsHelper

  ##
  # Logs in the given user account.

  def log_in( user_account )
    session[:user_account_id] = user_account.id
  end

  ##
  # Returns the currently logged-in user account, if any.
  # Returns nil if no user is logged in.
  # In order to avoid hitting the database with every call, this method memoizes the result to an instance variable.

  def current_user_account
    @current_user_account ||= UserAccount.find_by( id: session[:user_account_id] )
  end

  ##
  # Logs out the current user.

  def log_out
    session.delete( :user_account_id )
    @current_user_account = nil
  end

  ##
  # Returns true if the current user is logged in, false otherwise.

  def logged_in?
    !current_user_account.nil?
  end
end
