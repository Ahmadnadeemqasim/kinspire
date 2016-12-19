class Kinployment
  module Scoring
    module Availability

      ##
      # A service object that calculates the strength of a match between a
      # Kinployment and Kinployee in terms of availability.

      class SimpleAvailabilityScorer

        ##
        # Constructor.

        def initialize( kinployment, kinployee )
          @kinployment  = kinployment
          @kinployee    = kinployee
        end

        ##
        # Calculate the availibility match score between this instance's
        # Kinployment and Kinployee.
        # Must return a value between 0 and 100.

        def call
          @kinployment.preferred_availability <= @kinployee.availability ?
            100 :
            0
        end

      end
    end
  end
end