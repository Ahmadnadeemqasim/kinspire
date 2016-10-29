class UserAccountsController < ApplicationController
  def new
  end

  def show
    @user_account = UserAccount.find( params[:id] )
  end
end
