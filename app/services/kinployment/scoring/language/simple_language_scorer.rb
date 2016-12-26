class Kinployment
  module Scoring
    module Language

      ##
      # A service object that calculates the strength of a match between a
      # Kinployment and Kinployee in terms of Kinployee language.

      class SimpleLanguageScorer

        ##
        # Constructor.

        def initialize( kinployment, kinployee )
          @kinployment  = kinployment
          @kinployee    = kinployee
        end

        ##
        # Calculate the language match score between this instance's
        # Kinployment and Kinployee.

        def call
          num_matching_languages = (  @kinployee.languages &
                                      @kinployment.preferred_languages ).length
          
          num_matching_languages.to_f / @kinployment.preferred_languages.length
        end
      end
    end
  end
end