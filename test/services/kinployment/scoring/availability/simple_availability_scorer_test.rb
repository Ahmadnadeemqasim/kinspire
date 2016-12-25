require 'test_helper'

module Kinployment::Scoring::Availability
  class SimpleAvailabilityScorerTest < ActiveSupport::TestCase

    test "must return 100 if Kinployee availability is greater than or equal to Kinployment preferred availability, 0 otherwise" do
      kinployment = Kinployment.new( preferred_availability: 20 )
      kinployee_gt  = Kinployee.new( availability: 21 )
      kinployee_eq  = Kinployee.new( availability: 20 )
      kinployee_lt  = Kinployee.new( availability: 19 )

      result_gt = SimpleAvailabilityScorer.new( kinployment, kinployee_gt ).call
      result_eq = SimpleAvailabilityScorer.new( kinployment, kinployee_eq ).call
      result_lt = SimpleAvailabilityScorer.new( kinployment, kinployee_lt ).call

      # Use .eql? to ensure results are Floats.
      assert result_gt.eql?( 100.0 ), "Expected false to be truthy. Ensure result is a Float and has correct value."
      assert result_eq.eql?( 100.0 ), "Expected false to be truthy. Ensure result is a Float and has correct value."
      assert result_lt.eql?( 0.0 ),   "Expected false to be truthy. Ensure result is a Float and has correct value."
    end
  end
end