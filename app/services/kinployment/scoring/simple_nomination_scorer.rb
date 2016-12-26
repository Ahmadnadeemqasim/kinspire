class Kinployment
  module Scoring

    ##
    # A service object that calculates a simple mesure of the strength of a
    # match between a Kinployment and Kinployee.

    class SimpleNominationScorer

      ##
      # Constructor.

      def initialize( kinployment, kinployee )
        @kinployment  = kinployment
        @kinployee    = kinployee
      end

      ##
      # Calculate the match score between this instance's Kinployment and Kinployee.

      def call
        scores = {
          availability: Availability::SimpleAvailabilityScorer.new(
                                        @kinployment, @kinployee ).call,
          culture:      Culture::SimpleCultureScorer.new(
                                        @kinployment, @kinployee ).call,
          language:     Language::SimpleLanguageScorer.new(
                                        @kinployment, @kinployee ).call,
          location:     Location::SimpleLocationScorer.new(
                                        @kinployment, @kinployee ).call,
          sex:          Sex::SimpleSexScorer.new(
                                        @kinployment, @kinployee ).call,
          skills:       Skills::SimpleSkillsScorer.new(
                                        @kinployment, @kinployee ).call
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