class Kinployment
  module Scoring
    module Location

      ##
      # A service object that calculates the strength of a match between a
      # Kinployment and Kinployee in terms of location.

      class SimpleLocationScorer

        ##
        # Constructor.

        def initialize( kinployment, kinployee )
          @kinployment  = kinployment
          @kinployee    = kinployee
        end

        ##
        # Calculate the location match score between this instance's
        # Kinployment and Kinployee.
        # Must return a value between 0 and 100.

        def call
          return 0.0  if @kinployment.location[:state] != @kinployee.location[:state]
          return 20.0 if @kinployment.location[:city] != @kinployee.location[:city]
          return 100.0
        end

      end
    end
  end
end