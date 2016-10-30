class UserAccountsController < ApplicationController

  def new
    @user_account = UserAccount.new
  end

  def create
    @user_account = UserAccount.new( user_account_params )
    if @user_account.save
      redirect_to @user_account
    else
      render 'new'
    end
  end

  def show
    @user_account = UserAccount.find( params[:id] )
  end

  private

    ##
    # Define how parameters may be mass-assigned to UserAccount objects.

    def user_account_params
      params.require( :user_account ).permit( :email,
                                              :password, :password_confirmation )
    end
end
