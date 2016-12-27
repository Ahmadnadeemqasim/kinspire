class Kinployment
  module Scoring
    module Skills

      ##
      # A service object that calculates the strength of a match between a
      # Kinployment and Kinployee in terms of Kinployee skills.

      class SimpleSkillsScorer

        ##
        # Constructor.

        def initialize( kinployment )
          @kinployment  = kinployment
        end

        ##
        # Calculate the skills match score for the given Kinployee
        # relative to this instance's Kinployment.

        def score_for( kinployee )
          num_matching_skills =
            ( kinployee.skills & @kinployment.preferred_skills )
              .length

          num_matching_skills.to_f / @kinployment.preferred_skills.length
        end
      end
    end
  end
end