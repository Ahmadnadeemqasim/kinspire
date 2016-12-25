class Kinployment

  ##
  # An object representing a Kinployee candidate for a Kinployment job.
  #
  # Each Nomination takes a Kinployment, a Kinployee, and a Hash of scores
  # representing a measurement of how strong of a match the candidate is for
  # the job across various dimensions.
  #
  # An overall score is required in the Hash. All other scores are optional.
  #
  # This object is immutable.
  
  class Nomination
    include Comparable

    class MissingOverallScoreError < ArgumentError; end
    class ScoreOutOfRangeError < ArgumentError; end

    attr_reader :kinployment, :kinployee

    ##
    # Constructor.
    # Takes a Kinployment, a Kinployee, and a Hash of scores.

    def initialize( kinployment, kinployee, scores )
      raise MissingOverallScoreError unless scores[:overall]

      scores.each do |key, value|
        if value < 0.0 || value > 100.0
          raise ScoreOutOfRangeError, "Score for '#{key}' has invalid value of #{value}."
        end
      end

      @kinployment  = kinployment
      @kinployee    = kinployee
      @scores       = scores
    end

    ##
    # Compare based on overall score.

    def <=>( other )
      overall_score <=> other.overall_score
    end

    ##
    # Return the value of the overall score.

    def overall_score
      score_for( :overall )
    end

    ##
    # Return the value of the requested score.

    def score_for( dimension )
      @scores[dimension]
    end
  end
end