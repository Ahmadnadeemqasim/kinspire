class Kinployment
  module Scoring
    module Location

      ##
      # A service object that calculates the strength of a match between a
      # Kinployment and Kinployee in terms of location.

      class SimpleLocationScorer

        ##
        # Constructor.

        def initialize( kinployment )
          @kinployment  = kinployment
        end

        ##
        # Calculate the location match score for the given Kinployee
        # relative to this instance's Kinployment.

        def score_for( kinployee )
          return 0.0  if @kinployment.location[:state] != kinployee.location[:state]
          return 0.2 if @kinployment.location[:city] != kinployee.location[:city]
          return 1.0
        end

      end
    end
  end
end