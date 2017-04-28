class KinploymentsController < ApplicationController

  def create
    # Fix attribute formats.
    params[:kinployment][:location] = {
      city:   params[:city],
      state:  params[:state] }
    params[:kinployment][:cultural_backgrounds].delete( "" )
    params[:kinployment][:preferred_languages] = params[:kinployment][:preferred_languages].split( ',' ).map{ |s| s.strip }.map{ |s| s.downcase }
    params[:kinployment][:preferred_skills].delete( "" )

    @kinployment = current_user.kinployer.kinployments.build( kinployment_params )
    if @kinployment.save
      redirect_to @kinployment
    else
      render 'new'
    end
  end

  def disengage
    @kinployment = Kinployment.find( params[:id] )
    @kinployment.disengage
    @kinployment.save
    redirect_to @kinployment
  end

  def engage
    @kinployment  = Kinployment.find( params[:id] )
    @kinployee    = Kinployee.find( params[:kinployee_id] )
    if @kinployment.engage( @kinployee ) and @kinployment.save
      redirect_to @kinployment
    else
      raise Exceptions::ApplicationError, "Failed to engage the indicated Kinployee."
    end
  end

  def new
    @kinployment = Kinployment.new
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
          :name,
          { cultural_backgrounds: [] },
          :culture_match_preference,
          { location: [ :city, :state ] },
          :preferred_availability,
          { preferred_languages: [] },
          :preferred_sex,
          { preferred_skills: [] } )
    end

end