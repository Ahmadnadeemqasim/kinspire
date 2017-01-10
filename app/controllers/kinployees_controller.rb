class KinployeesController < ApplicationController

  def new
    @user = User.new
    @kinployee = Kinployee.new
  end

  def create
    # Fix attribute formats.
    kp = kinployee_params
    kp[:cultural_backgrounds].delete( "" )                  # Collection checkboxes always include an empty string.
    kp[:languages] = kp[:languages].split( ',' )            # This is entered as a single string by the user, but should be an array of strings.
                                   .map{ |s| s.strip }
                                   .map{ |s| s.downcase }
    kp[:location] = { city:  kp.delete( :city ),            # This is entered as two separate strings but should be a single hash containing the two strings.
                      state: kp.delete( :state ) }
    kp[:skills].delete( "" )                                # Collection checkboxes always include an empty string.


    @kinployee = Kinployee.new( kp )
    @user = User.new( user_params )
    @user.kinployee = @kinployee
    if @user.save
      log_in @user
      redirect_to @kinployee
    else
      render 'new'
    end
  end

  def show
    @user = current_user
    @kinployee = @user.kinployee
  end

  private

    ##
    # Define what paramaters may be mass-assigned to Kinployee objects.

    def kinployee_params
      params.require( :user )
              .require( :kinployee )
                .permit(  :availability,
                          { cultural_backgrounds: [] },
                          :culture_match_preference,
                          :languages,
                          :city,
                          :state,
                          :sex,
                          { skills: [] })
    end

    ##
    # Define what parameters may be mass-assigned to User objects.

    def user_params
      params.require( :user ).permit( :email,
                                      :password, :password_confirmation,
                                      :role )
    end
end
