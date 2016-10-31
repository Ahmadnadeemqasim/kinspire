class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    
    user_account = UserAccount.find_by( email: email )
    if user_account && user_account.authenticate( password )
      log_in user_account
      redirect_to user_account
    else
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
