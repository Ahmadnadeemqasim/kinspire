class Kinployment
  module Scoring
    module Sex

      ##
      # A service object that calculates the strength of a match between a
      # Kinployment and Kinployee in terms of Kinployee sex (gender).

      class SimpleSexScorer

        ##
        # Constructor.

        def initialize( kinployment, kinployee )
          @kinployment  = kinployment
          @kinployee    = kinployee
        end

        ##
        # Calculate the sex (gender) match score between this instance's
        # Kinployment and Kinployee.
        # Must return a value between 0 and 100.

        def call
          kinployment_preference = @kinployment.preferred_sex
          kinployee_sex = @kinployee.sex
          return 100.0  if kinployment_preference == kinployee_sex
          return 80.0   if kinployment_preference == 'no_preference'
          return 20.0   if kinployee_sex          == 'other'
          return 0.0
        end

      end
    end
  end
end