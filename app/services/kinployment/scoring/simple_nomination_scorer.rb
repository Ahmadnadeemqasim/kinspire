class Kinployment
  module Scoring

    ##
    # A service object that calculates a simple mesure of the strength of a
    # match between a Kinployment and Kinployee.

    class SimpleNominationScorer

      ##
      # Constructor.

      def initialize( kinployment )
        @kinployment  = kinployment

        @availability_scorer  = Availability::SimpleAvailabilityScorer.new( @kinployment )
        @culture_scorer       = Culture::SimpleCultureScorer.new( @kinployment )
        @language_scorer      = Language::SimpleLanguageScorer.new( @kinployment )
        @location_scorer      = Location::SimpleLocationScorer.new( @kinployment )
        @sex_scorer           = Sex::SimpleSexScorer.new( @kinployment )
        @skills_scorer        = Skills::SimpleSkillsScorer.new( @kinployment )
      end

      ##
      # Calculate the match score for the given Kinployee relative to this
      # instance's Kinployment.

      def score_for( kinployee )
        scores = {
          availability: @availability_scorer
                          .score_for( kinployee ),
          culture:      @culture_scorer
                          .score_for( kinployee ),
          language:     @language_scorer
                          .score_for( kinployee ),
          location:     @location_scorer
                          .score_for( kinployee ),
          sex:          @sex_scorer
                          .score_for( kinployee ),
          skills:       @skills_scorer
                          .score_for( kinployee )
        }

        if scores[:availability] == 0.0 || scores[:skills] == 0.0
          scores[:overall] = 0.0
        else
          scores[:overall] = scores.values.reduce( 0.0, :+ ) / scores.length # average of all scores
        end

        return scores
      end
    end
  end
end