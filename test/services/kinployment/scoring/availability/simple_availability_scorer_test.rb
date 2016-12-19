require 'test_helper'

module Kinployment::Scoring::Availability
  
  class SimpleAvailabilityScorerTest < ActiveSupport::TestCase

    test "must return 100 if Kinployee availability is less than or equal to Kinployment desired availability, 0 otherwise" do
      kinployment20 = Kinployment.new( desired_availability: 20 )
      kinployee21   = Kinployee.new( availability: 21 )
      kinployee20   = Kinployee.new( availability: 20 )
      kinployee19   = Kinployee.new( availability: 19 )

      assert_equal 100, SimpleAvailabilityScorer.new(
        kinployment20, kinployee21
      ).call
      assert_equal 100, SimpleAvailabilityScorer.new(
        kinployment20, kinployee20
      ).call
      assert_equal 0, SimpleAvailabilityScorer.new(
        kinployment20, kinployee19
      ).call
    end
  end
end