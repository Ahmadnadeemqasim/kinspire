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
        # Must return a value between 0.0 and 100.0.

        def call
          num_matching_languages = (  @kinployee.languages &
                                      @kinployment.preferred_languages ).length
          fraction_matching_languages = num_matching_languages.to_f /
                                        @kinployment.preferred_languages.length
          100 * fraction_matching_languages
        end
      end
    end
  end
end