require 'test_helper'

class NominatorTest < ActiveSupport::TestCase

  UNSORTED_SCORES = [0.3, 0.0, 0.5, 0.6, 0.1, 0.5]

  class FakeNominationScorer
    def initialize( kinployment )
      @kinployment = kinployment
      @enumerator = UNSORTED_SCORES.each
    end

    def score_for( kinployee )
      { overall: @enumerator.next }
    end
  end

  test "must return a sorted NominationList" do
    kinployees = UNSORTED_SCORES.map{ Kinployee.new }
    
    result = Kinployment::Nominator
              .new( Kinployment.new, kinployees, FakeNominationScorer )
              .call
    scores = result.map{ |n| n.overall_score }

    assert_equal Kinployment::NominationList, result.class
    assert_equal UNSORTED_SCORES.sort.reverse, scores
  end
end