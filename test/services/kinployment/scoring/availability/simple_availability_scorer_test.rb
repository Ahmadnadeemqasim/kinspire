require 'test_helper'

module Kinployment::Scoring::Availability
  class SimpleAvailabilityScorerTest < ActiveSupport::TestCase

    test "must return 1.0 if Kinployee availability is greater than or equal to Kinployment preferred availability, 0.0 otherwise" do
      kinployment = Kinployment.new( preferred_availability: 20 )
      kinployee_gt  = Kinployee.new( availability: 21 )
      kinployee_eq  = Kinployee.new( availability: 20 )
      kinployee_lt  = Kinployee.new( availability: 19 )
      subject = SimpleAvailabilityScorer.new( kinployment )

      result_gt = subject.score_for( kinployee_gt )
      result_eq = subject.score_for( kinployee_eq )
      result_lt = subject.score_for( kinployee_lt )

      # Use .eql? to ensure results are Floats.
      assert result_gt.eql?( 1.0 ), "Unexpected value: #{result_gt}. Ensure result is a Float and has correct value."
      assert result_eq.eql?( 1.0 ), "Unexpected value: #{result_eq}. Ensure result is a Float and has correct value."
      assert result_lt.eql?( 0.0 ), "Unexpected value: #{result_lt}. Ensure result is a Float and has correct value."
    end
  end
end