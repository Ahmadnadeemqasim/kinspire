class Kinployment

  ##
  # A value object representing a Kinployee candidate for a Kinployment job.
  # Each nomination must have a score, representing the system's calculation of
  # how strong of a match the candidate is for the job.
  
  class Nomination
    include Comparable

    class ScoreOutOfRangeError < ArgumentError; end

    attr_reader :kinployment, :kinployee, :score

    ##
    # Constructor.

    def initialize( kinployment, kinployee, score )
      raise ScoreOutOfRangeError if score < 0 || score > 100

      @kinployment  = kinployment
      @kinployee    = kinployee
      @score        = score
    end

    ##
    # Determine equality based on value, not identity.

    def ==( other )
      @kinployment  == other.kinployment &&
      @kinployee    == other.kinployee &&
      @score        == other.score
    end

    ##
    # Compare based on score.

    def <=>( other )
      @score <=> other.score
    end
  end
end