module SessionsHelper

  ##
  # Return the currently logged-in user account.
  # If no user account is logged in, return the currently remembered user account.
  # If no user is logged in or remembered, return nil.
  # In order to avoid hitting the database with every call, this method memoizes
  # the result to an instance variable.

  def current_user_account
    if user_account_id = session[:user_account_id]
      @current_user_account ||= UserAccount.find_by( id: user_account_id )
    elsif user_account_id = cookies.signed[:user_account_id]
      user_account = UserAccount.find_by( id: user_account_id )
      if user_account && user_account.authentic_remember_login_token?( 
                                      cookies[:remember_login_token] )
        log_in user_account
        @current_user_account = user_account
      end
    end
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
