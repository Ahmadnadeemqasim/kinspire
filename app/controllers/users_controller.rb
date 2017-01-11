class UsersController < ApplicationController
  
  def show
    @user = User.find( params[:id] )
    return redirect_to kinployee_path( @user.kinployee ) if @user.is_kinployee?
    return redirect_to kinployer_path( @user.kinployer ) if @user.is_kinployer?
  end
  
end
