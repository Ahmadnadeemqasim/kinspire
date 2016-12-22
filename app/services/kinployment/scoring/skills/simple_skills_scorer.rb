class Kinployment
  module Scoring
    module Skills

      ##
      # A service object that calculates the strength of a match between a
      # Kinployment and Kinployee in terms of Kinployee skills.

      class SimpleSkillsScorer

        ##
        # Constructor.

        def initialize( kinployment, kinployee )
          @kinployment  = kinployment
          @kinployee    = kinployee
        end

        ##
        # Calculate the skills match score between this instance's
        # Kinployment and Kinployee.
        # Must return a value between 0 and 100.

        def call
          num_matching_skills = ( @kinployee.skills &
                                  @kinployment.preferred_skills ).length
          fraction_matching_skills  = num_matching_skills.to_f /
                                      @kinployment.preferred_skills.length
          100 * fraction_matching_skills
        end
      end
    end
  end
end