class Kinployment
  module Scoring
    module Culture

      ##
      # A service object that calculates the strength of a match between a
      # Kinployment and Kinployee in terms of culture.

      class SimpleCultureScorer

        ##
        # Constructor.

        def initialize( kinployment, kinployee )
          @kinployment  = kinployment
          @kinployee    = kinployee

          @kinployment_backgrounds       = @kinployment.cultural_backgrounds
          @kinployment_match_preference  = @kinployment.culture_match_preference
          @kinployee_backgrounds       = @kinployee.cultural_backgrounds
          @kinployee_match_preference  = @kinployee.culture_match_preference
        end

        ##
        # Calculate the culture match score between this instance's
        # Kinployment and Kinployee.
        # Must return a value between 0.0 and 100.0.

        def call
          kinployment_score = case @kinployment_match_preference
            when 'no_preference'  then 1.0
            when 'similar'        then kinployment_similar_culture_score
            when 'not_similar'    then kinployment_dissimilar_culture_score
          end

          kinployee_score = case @kinployee_match_preference
            when 'no_preference'  then 1.0
            when 'similar'        then kinployee_similar_culture_score
            when 'not_similar'    then kinployee_dissimilar_culture_score
          end

          kinployment_score * kinployee_score * 100.0
        end

        private

          def num_common_backgrounds
            @num_common_backgrounds ||=
              ( @kinployment_backgrounds & @kinployee_backgrounds ).length
          end

          ##
          # Must return a value between 0.0 and 1.0.

          def kinployment_dissimilar_culture_score
            1.0 - kinployment_similar_culture_score
          end

          ##
          # Must return a value between 0.0 and 1.0.

          def kinployment_similar_culture_score
            num_common_backgrounds.to_f / @kinployment_backgrounds.length
          end

          ##
          # Must return a value between 0.0 and 1.0.

          def kinployee_dissimilar_culture_score
            1.0 - kinployee_similar_culture_score
          end

          ##
          # Must return a value between 0.0 and 1.0.

          def kinployee_similar_culture_score
            num_common_backgrounds.to_f / @kinployee_backgrounds.length
          end
      end
    end
  end
end