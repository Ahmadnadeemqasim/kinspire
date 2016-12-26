require 'test_helper'

class NominationTest < ActiveSupport::TestCase
  Nomination = Kinployment::Nomination

  def setup
    @kinployment  = Kinployment.new
    @kinployee    = Kinployee.new
  end

  test "all scores must be between 0 and 1.0" do
    valid_scores = {  overall: 0.5,
                      availability: 0.0, culture: 0.5, langauge: 1.0 }
    invalid_scores_low  = valid_scores.dup; invalid_scores_low[:language]  = -0.001
    invalid_scores_high = valid_scores.dup; invalid_scores_high[:language] = 1.001

    assert_nothing_raised do 
      Nomination.new( @kinployment, @kinployee, valid_scores )
    end
    assert_raises Nomination::ScoreOutOfRangeError do
      Nomination.new( @kinployment, @kinployee, invalid_scores_low )
    end
    assert_raises Nomination::ScoreOutOfRangeError do
      Nomination.new( @kinployment, @kinployee, invalid_scores_high )
    end
  end

  test "must include an overall score" do
    assert_raises Nomination::MissingOverallScoreError do
      Nomination.new( @kinployment, @kinployee, { availability: 0.5 } )
    end
  end

  test "must be immutable" do
    nomination = Nomination.new( @kinployment, @kinployee, { overall: 0.4 } )

    assert_raises Exception, "Expected attribute to be immutable." do
      nomination.kinployment = Kinployment.new
    end
    assert_raises Exception, "Expected attribute to be immutable." do
      nomination.kinployee = Kinployee.new
    end
    assert_raises Exception, "Expected attribute to be immutable." do
      nomination.scores = { availability: 0.2 }
    end
  end

  test "must be comparable based on overall score" do
    nomination_low   = Nomination.new( @kinployment, @kinployee, { overall: 0.50 } )
    nomination_high  = Nomination.new( @kinployment, @kinployee, { overall: 0.51 } )

    assert nomination_high > nomination_low,
      "Expected nominations to be comparable based on their score."
    assert nomination_low < nomination_high,
      "Expected nominations to be comparable based on their score."
  end

  ##
  # #overall_score

  test "#overall_score must return the value of the overall score" do
    nomination = Nomination.new( @kinployment, @kinployee,
                    { overall: 0.123456, availability: 0.5 } )

    assert_equal 0.123456, nomination.overall_score
  end

  ##
  # #score_for

  test "#score_for must return the requested score" do
    scores = {  overall: 0.5, availability: 0.0,
                culture: 0.5, langauge: 1.0 }
    nomination = Nomination.new( @kinployment, @kinployee, scores )

    scores.each do |key, value|
      assert_equal value, nomination.score_for( key )
    end
  end
end