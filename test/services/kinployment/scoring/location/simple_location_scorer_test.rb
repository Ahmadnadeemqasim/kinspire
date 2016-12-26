require 'test_helper'

module Kinployment::Scoring::Location
  class SimpleLocationScorerTest < ActiveSupport::TestCase

    test "must return 1.0 if Kinployment and Kinployee locations match exactly" do
      kinployment = Kinployment.new( location: { city: 'San Francisco', state: 'CA' } )
      kinployee   = Kinployee.new( location: { city: 'San Francisco', state: 'CA' } )

      result = SimpleLocationScorer.new( kinployment, kinployee ).call

      assert result.eql?( 1.0 ), "Unexpected value: #{result}. Ensure result is a Float and has correct value."
    end

    test "must return 0.2 if Kinployment and Kinployee state matches, but city differs" do
      kinployment = Kinployment.new( location: { city: 'San Francisco', state: 'CA' } )
      kinployee   = Kinployee.new( location: { city: 'Los Angeles', state: 'CA' } )

      result = SimpleLocationScorer.new( kinployment, kinployee ).call

      assert result.eql?( 0.2 ), "Unexpected value: #{result}. Ensure result is a Float and has correct value."
    end

    test "must return 0.0 if Kinployment and Kinployee are in different states" do
      kinployment = Kinployment.new( location: { city: 'San Francisco', state: 'CA' } )
      kinployee   = Kinployee.new( location: { city: 'Miami', state: 'FL' } )

      result = SimpleLocationScorer.new( kinployment, kinployee ).call

      assert result.eql?( 0.0 ), "Unexpected value: #{result}. Ensure result is a Float and has correct value."
    end
  end
end