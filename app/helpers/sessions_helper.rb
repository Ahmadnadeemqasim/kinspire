module SessionsHelper

  ##
  # Return the currently logged-in user.
  # If no user is logged in, return the currently remembered user.
  # If no user is logged in or remembered, return nil.
  # In order to avoid hitting the database with every call, this method memoizes
  # the result to an instance variable.

  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by( id: user_id )
    elsif user_id = cookies.signed[:user_id]
      user = User.find_by( id: user_id )
      if user && user.authenticate_remember_login_token( cookies[:remember_login_token] )
        log_in user
        @current_user = user
      end
    end
  end

  ##
  # Stop user login from persisting between sessions.

  def forget_login( user )
    user.forget_login
    cookies.delete( :remember_login_token )
    cookies.delete( :user_id )
  end

  ##
  # Log in the given user.

  def log_in( user )
    session[:user_id] = user.id
  end

  ##
  # Log out the current user.

  def log_out
    forget_login( current_user )
    session.delete( :user_id )
    @current_user = nil
  end

  ##
  # Return true if the current user is logged in, false otherwise.

  def logged_in?
    !current_user.nil?
  end

  ##
  # Keep the user logged in between sessions.

  def remember_login( user )
    user.remember_login
    cookies.permanent[:remember_login_token] = user.remember_login_token
    cookies.permanent.signed[:user_id] = user.id
  end
end
