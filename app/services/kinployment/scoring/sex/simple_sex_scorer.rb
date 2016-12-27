class Kinployment
  module Scoring
    module Sex

      ##
      # A service object that calculates the strength of a match between a
      # Kinployment and Kinployee in terms of Kinployee sex (gender).

      class SimpleSexScorer

        ##
        # Constructor.

        def initialize( kinployment )
          @kinployment  = kinployment
        end

        ##
        # Calculate the sex (gender) match score for the given Kinployee
        # relative to this instance's Kinployment.

        def score_for( kinployee )
          kinployment_preference = @kinployment.preferred_sex
          kinployee_sex = kinployee.sex
          return 1.0  if kinployment_preference == kinployee_sex
          return 0.8  if kinployment_preference == 'no_preference'
          return 0.2  if kinployee_sex          == 'other'
          return 0.0
        end

      end
    end
  end
end