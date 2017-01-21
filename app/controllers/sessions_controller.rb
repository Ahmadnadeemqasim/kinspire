class SessionsController < ApplicationController
  def new
    render 'login'
  end

  def create
    email       = params[:session][:email].downcase
    password    = params[:session][:password]
    remember    = params[:session][:remember_login]
    
    @user = User.find_by( email: email )
    if @user && @user.authenticate( password )
      # Log in.
      log_in @user

      # Handle login persistence.
      remember == '1' ? remember_login( @user ) :
                        forget_login( @user )

      redirect_to @user
    else
      render 'login'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
