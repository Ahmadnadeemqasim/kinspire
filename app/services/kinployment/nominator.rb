class Kinployment

  ##
  # A service object to generate a list of scored Nominations of
  # Kinployees for a given Kinployment.

  class Nominator

    ##
    # Constructor.
    # Takes the Kinployment being nominated for, an Array of Kinployees
    # to nominate, and the scorer class to use to calculate scores.

    def initialize( kinployment, kinployees, scorer_class )
      @kinployment  = kinployment
      @kinployees   = kinployees
      @scorer       = scorer_class.new( @kinployment )
    end

    ##
    # Generate a NominationList for this instance's Kinployees,
    # sorted in descending order of best match.

    def call
      nominations = NominationList.new( @kinployment )
      @kinployees.each do |kinployee|
        scores = @scorer.score_for( kinployee )
        nominations << Nomination.new(  @kinployment,
                                        kinployee,
                                        scores )
      end
      nominations.sort!
    end
  end
end