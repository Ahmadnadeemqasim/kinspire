class UsersController < ApplicationController

  # def new
  #   @user = User.new
  # end

  # def create
  #   @user = User.new( user_params )
  #   if @user.save
  #     log_in @user
  #     redirect_to @user
  #   else
  #     render 'new'
  #   end
  # end

  def show
    @user = User.find( params[:id] )
    redirect_to kinployee_path( @user.kinployee ) if @user.is_kinployee?
  end

  private

    ##
    # Define how parameters may be mass-assigned to User objects.

    def user_params
      params.require( :user ).permit( :email,
                                      :password, :password_confirmation,
                                      :role )
    end
end
