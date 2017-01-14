class NominationsController < ApplicationController

  def index
    @kinployment  = Kinployment.find( params[:kinployment_id] )
    @nominations  = Kinployment::Nominator
                      .new(
                        @kinployment,
                        Kinployee.all,
                        Kinployment::Scoring::SimpleNominationScorer )
                      .call
  end

end