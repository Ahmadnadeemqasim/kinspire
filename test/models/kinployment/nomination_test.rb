require 'test_helper'

class NominationTest < ActiveSupport::TestCase

  def setup
    @kinployment  = Kinployment.new
    @kinployee    = Kinployee.new
  end

  test "score must be between 0 and 100" do
    valid_scores    = [0, 1, 99, 100]
    invalid_scores  = [-1, 101]

    valid_scores.each do |score|
      assert_nothing_raised do 
        Kinployment::Nomination.new( @kinployment, @kinployee, score )
      end
    end
    invalid_scores.each do |score|
      assert_raises Kinployment::Nomination::ScoreOutOfRangeError do
        Kinployment::Nomination.new( @kinployment, @kinployee, score)
      end
    end
  end

  ##
  # Value object behavior.

  test "equality must be determined by value, not identity" do
    equal_nomination1                 = Kinployment::Nomination.new( @kinployment, @kinployee, 50 )
    equal_nomination2                 = Kinployment::Nomination.new( @kinployment, @kinployee, 50 )
    different_kinployment_nomination  = Kinployment::Nomination.new( Kinployment.new, @kinployee, 50 )
    different_kinployee_nomination    = Kinployment::Nomination.new( @kinployment, Kinployee.new, 50 )

    assert_equal equal_nomination1, equal_nomination2,
      "Expected nominations with equal values to be equal."
    assert_not_equal different_kinployment_nomination, equal_nomination1,
      "Expected nominations with different Kinployments to be unequal."
    assert_not_equal different_kinployee_nomination,   equal_nomination1,
      "Expected nominations with different Kinployees to be unequal."
  end

  test "must be immutable" do
    nomination = Kinployment::Nomination.new( @kinployment, @kinployee, 50 )

    assert_raises Exception, "Expected attribute to be immutable." do
      nomination.kinployment = Kinployment.new
    end
    assert_raises Exception, "Expected attribute to be immutable." do
      nomination.kinployee = Kinployee.new
    end
    assert_raises Exception, "Expected attribute to be immutable." do
      nomination.score = 20
    end
  end

  test "must be comparable based on score" do
    low_nomination   = Kinployment::Nomination.new( @kinployment, @kinployee, 50 )
    high_nomination  = Kinployment::Nomination.new( @kinployment, @kinployee, 51 )

    assert high_nomination > low_nomination,
      "Expected nominations to be comparable based on their score."
    assert low_nomination < high_nomination,
      "Expected nominations to be comparable based on their score."
  end
end