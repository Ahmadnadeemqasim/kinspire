require 'test_helper'

module Kinployment::Scoring::Sex
  class SimpleSexScorerTest < ActiveSupport::TestCase

    def kinployment_male
      Kinployment.new( preferred_sex: 'male' )
    end

    def kinployment_female
      Kinployment.new( preferred_sex: 'female' )
    end

    def kinployment_no_preference
      Kinployment.new( preferred_sex: 'no_preference' )
    end

    def kinployee_male
      Kinployee.new( sex: 'male' )
    end

    def kinployee_female
      Kinployee.new( sex: 'female' )
    end

    def kinployee_other
      Kinployee.new( sex: 'other' )
    end

    ##
    # Tests

    test "must return 1.0 if Kinployment sex preference and Kinployee sex match exactly" do
      result_mm = SimpleSexScorer.new( kinployment_male ).score_for( kinployee_male )
      result_ff = SimpleSexScorer.new( kinployment_female ).score_for( kinployee_female )

      assert result_mm.eql?( 1.0 ), "Unexpected value: #{result_mm}. Ensure result is a Float and has correct value."
      assert result_ff.eql?( 1.0 ), "Unexpected value: #{result_ff}. Ensure result is a Float and has correct value."
    end

    test "must return 0.0 if Kinployment sex preference and Kinployee sex are exact opposites" do
      result_mf = SimpleSexScorer.new( kinployment_male ).score_for( kinployee_female )
      result_fm = SimpleSexScorer.new( kinployment_female ).score_for( kinployee_male )

      assert result_mf.eql?( 0.0 ), "Unexpected value: #{result_mf}. Ensure result is a Float and has correct value."
      assert result_fm.eql?( 0.0 ), "Unexpected value: #{result_fm}. Ensure result is a Float and has correct value."
    end

    test "if Kinployment expresses no sex preference, must return expected score" do
      result_nm = SimpleSexScorer.new( kinployment_no_preference ).score_for( kinployee_male )
      result_nf = SimpleSexScorer.new( kinployment_no_preference ).score_for( kinployee_female )
      result_no = SimpleSexScorer.new( kinployment_no_preference ).score_for( kinployee_other )

      assert result_nm.eql?( 0.8 ), "Unexpected value: #{result_nm}. Ensure result is a Float and has correct value."
      assert result_nf.eql?( 0.8 ), "Unexpected value: #{result_nf}. Ensure result is a Float and has correct value."
      assert result_no.eql?( 0.8 ), "Unexpected value: #{result_no}. Ensure result is a Float and has correct value."
    end

    test "if Kinployment prefers a specific sex, and Kinployee sex is 'other', must return expected score" do
      result_mo = SimpleSexScorer.new( kinployment_male ).score_for( kinployee_other )
      result_fo = SimpleSexScorer.new( kinployment_female ).score_for( kinployee_other )

      assert result_mo.eql?( 0.2 ), "Unexpected value: #{result_fo}. Ensure result is a Float and has correct value."
    end
  end
end