class Kinployment
  module Scoring
    module Language

      ##
      # A service object that calculates the strength of a match between a
      # Kinployment and Kinployee in terms of Kinployee language.

      class SimpleLanguageScorer

        ##
        # Constructor.

        def initialize( kinployment )
          @kinployment  = kinployment
        end

        ##
        # Calculate the language match score for the given Kinployee
        # relative to this instance's Kinployment.

        def score_for( kinployee )
          num_matching_languages =
            ( kinployee.languages & @kinployment.preferred_languages )
              .length
          
          num_matching_languages.to_f / @kinployment.preferred_languages.length
        end
      end
    end
  end
end