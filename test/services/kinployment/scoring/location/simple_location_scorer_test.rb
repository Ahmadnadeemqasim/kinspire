require 'test_helper'

module Kinployment::Scoring::Location
  class SimpleLocationScorerTest < ActiveSupport::TestCase

    test "must return 100.0 if Kinployment and Kinployee locations match exactly" do
      kinployment = Kinployment.new( location: { city: 'San Francisco', state: 'CA' } )
      kinployee   = Kinployee.new( location: { city: 'San Francisco', state: 'CA' } )

      result = SimpleLocationScorer.new( kinployment, kinployee ).call

      assert result.eql?( 100.0 )
    end

    test "must return 20.0 if Kinployment and Kinployee state matches, but city differs" do
      kinployment = Kinployment.new( location: { city: 'San Francisco', state: 'CA' } )
      kinployee   = Kinployee.new( location: { city: 'Los Angeles', state: 'CA' } )

      result = SimpleLocationScorer.new( kinployment, kinployee ).call

      assert result.eql?( 20.0 )
    end

    test "must return 0.0 if Kinployment and Kinployee are in different states" do
      kinployment = Kinployment.new( location: { city: 'San Francisco', state: 'CA' } )
      kinployee   = Kinployee.new( location: { city: 'Miami', state: 'FL' } )

      result = SimpleLocationScorer.new( kinployment, kinployee ).call

      assert result.eql?( 0.0 )
    end
  end
end