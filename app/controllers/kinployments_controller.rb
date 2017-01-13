class KinploymentsController < ApplicationController

  def new
    return redirect_to new_job_1_path
  end

  def new_step_1
    @kinployment = Kinployment.new
  end

  def new_step_2    # Prepare attributes to be passed to next form.
    @preferred_skills       = params[:kinployment][:preferred_skills]         # Collection checkboxes always include an empty string.
                                .map{ |s| "'#{s}'" }.join( ', ' )
    @urgency                = params[:kinployment][:urgency]
    @preferred_availability = params[:kinployment][:preferred_availability]
    @city                   = params[:city]
    @state                  = params[:state]

    @kinployment = Kinployment.new
  end


  def create
    # Fix attribute formats
    kp = kinployment_params
    kp[:cultural_backgrounds].delete( "" )              # Collection checkboxes always include an empty string.
    kp[:preferred_languages] = kp[:preferred_languages] # This is entered as a single string by the user, but should be an array of strings.
      .split( ',' )
      .map{ |s| s.strip }
      .map{ |s| s.downcase }
    city  = params[:kinployment][:city]
    state = params[:kinployment][:state]
    kp[:location] = { city:  city, state: state }       # This is entered as two separate strings but should be a single hash containing the two strings.
    preferred_skills = params[:kinployment][:preferred_skills]
      .split( ', ' ).map{ |s| s.delete( "'" ) }
    preferred_skills.delete( "" )                       # Collection checkboxes always include an empty string.
    kp[:preferred_skills] = preferred_skills

    # Redefine existing attributes incase we have to re-render the form.
    @preferred_skills       = preferred_skills
                                .map{ |s| "'#{s}'" }.join( ', ' )
    @urgency                = params[:kinployment][:urgency]
    @preferred_availability = params[:kinployment][:preferred_availability]
    @city                   = city
    @state                  = state

    @kinployment = current_user.kinployer.kinployments.build( kp )
    if @kinployment.save
      redirect_to @kinployment
    else
      render 'new_step_2'
    end
  end

  def show
    @kinployment  = Kinployment.find( params[:id] )
    @kinployer    = @kinployment.kinployer
    @kinployee    = @kinployment.kinployee
  end

  private

    ##
    # Define what paramaters may be mass-assigned to Kinployment objects.

    def kinployment_params
      params
        .require( :kinployment )
        .permit(
          :preferred_availability,
          { cultural_backgrounds: [] },
          :culture_match_preference,
          :preferred_languages,
          :preferred_sex,
          { preferred_skills: [] } )
    end

end