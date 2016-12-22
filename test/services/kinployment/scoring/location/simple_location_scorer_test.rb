require 'test_helper'

module Kinployment::Scoring::Location
  class SimpleLocationScorerTest < ActiveSupport::TestCase

    test "must return 100.0 if Kinployment and Kinployee locations match exactly" do
      kinployment = Kinployment.new( location: { city: 'San Francisco', state: 'CA' } )
      kinployee   = Kinployee.new( location: { city: 'San Francisco', state: 'CA' } )

      assert_equal  100.0,
                    SimpleLocationScorer.new( kinployment, kinployee ).call,
                    0.0001
    end

    test "must return 20.0 if Kinployment and Kinployee state matches, but city differs" do
      kinployment = Kinployment.new( location: { city: 'San Francisco', state: 'CA' } )
      kinployee   = Kinployee.new( location: { city: 'Los Angeles', state: 'CA' } )

      assert_equal  20.0,
                    SimpleLocationScorer.new( kinployment, kinployee ).call,
                    0.0001
    end

    test "must return 0.0 if Kinployment and Kinployee are in different states" do
      kinployment = Kinployment.new( location: { city: 'San Francisco', state: 'CA' } )
      kinployee   = Kinployee.new( location: { city: 'Miami', state: 'FL' } )

      assert_equal  0.0,
                    SimpleLocationScorer.new( kinployment, kinployee ).call,
                    0.0001
    end
  end
end