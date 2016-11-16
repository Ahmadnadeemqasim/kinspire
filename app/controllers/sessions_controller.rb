class SessionsController < ApplicationController
  def new
  end

  def create
    email       = params[:session][:email].downcase
    password    = params[:session][:password]
    remember    = params[:session][:remember_login]
    
    @user_account = UserAccount.find_by( email: email )
    if @user_account && @user_account.authenticate( password )
      # Log in.
      log_in @user_account

      # Handle login persistence.
      remember == '1' ? remember_login( @user_account ) :
                        forget_login( @user_account )

      redirect_to @user_account
    else
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
