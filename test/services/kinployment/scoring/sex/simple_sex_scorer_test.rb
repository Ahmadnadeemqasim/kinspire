require 'test_helper'

module Kinployment::Scoring::Sex
  class SimpleSexScorerTest < ActiveSupport::TestCase

    test "must return 100 if Kinployment sex preference matches Kinployee sex exactly, 0 if they oppose exactly" do
      kinployment_male    = Kinployment.new( preferred_sex: 'male' )
      kinployment_female  = Kinployment.new( preferred_sex: 'female' )
      kinployee_male    = Kinployee.new( sex: 'male' )
      kinployee_female  = Kinployee.new( sex: 'female' )

      assert_equal 100, SimpleSexScorer.new(
        kinployment_male, kinployee_male ).call
      assert_equal 100, SimpleSexScorer.new(
        kinployment_female, kinployee_female ).call
      assert_equal 0, SimpleSexScorer.new(
        kinployment_male, kinployee_female ).call
      assert_equal 0, SimpleSexScorer.new(
        kinployment_female, kinployee_male ).call
    end

    test "if Kinployment expresses no sex preference, must return expected score" do
      expected_score = 80
      kinployment_no_preference = Kinployment.new( preferred_sex: 'no_preference' )
      kinployee_male    = Kinployee.new( sex: 'male' )
      kinployee_female  = Kinployee.new( sex: 'female' )
      kinployee_other   = Kinployee.new( sex: 'other' )

      assert_equal expected_score, SimpleSexScorer.new(
        kinployment_no_preference, kinployee_male ).call
      assert_equal expected_score, SimpleSexScorer.new(
        kinployment_no_preference, kinployee_female ).call
      assert_equal expected_score, SimpleSexScorer.new(
        kinployment_no_preference, kinployee_other ).call
    end

    test "if Kinployment prefers a specific sex, and Kinployee sex is 'other', must return expected score" do
      expected_score = 20
      kinployment_male    = Kinployment.new( preferred_sex: 'male' )
      kinployment_female  = Kinployment.new( preferred_sex: 'female' )
      kinployee_other = Kinployee.new( sex: 'other' )

      assert_equal expected_score, SimpleSexScorer.new(
        kinployment_male, kinployee_other ).call
      assert_equal expected_score, SimpleSexScorer.new(
        kinployment_female, kinployee_other ).call
    end
  end
end