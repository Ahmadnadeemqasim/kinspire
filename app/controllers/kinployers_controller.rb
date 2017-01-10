class KinployersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @kinployer = Kinployer.new
    @user = User.new( user_params )
    @user.kinployer = @kinployer
    if @user.save
      log_in @user
      redirect_to @kinployer
    else
      render 'new'
    end
  end

  def show
    @user = current_user
    @kinployer = @user.kinployer
  end

  private

    ##
    # Define what parameters may be mass-assigned to User objects.

    def user_params
      params.require( :user ).permit( :email,
                                      :password, :password_confirmation,
                                      :role )
    end
end
