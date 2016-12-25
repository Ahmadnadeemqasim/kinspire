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

    test "must return 100.0 if Kinployment sex preference and Kinployee sex match exactly" do
      result_mm = SimpleSexScorer.new( kinployment_male, kinployee_male ).call
      result_ff = SimpleSexScorer.new( kinployment_female, kinployee_female ).call

      assert result_mm.eql?( 100.0 ), "Expected false to be truthy. Ensure result is a Float and has correct value."
      assert result_ff.eql?( 100.0 ), "Expected false to be truthy. Ensure result is a Float and has correct value."
    end

    test "must return 0.0 if Kinployment sex preference and Kinployee sex are exact opposites" do
      result_mf = SimpleSexScorer.new( kinployment_male, kinployee_female ).call
      result_fm = SimpleSexScorer.new( kinployment_female, kinployee_male ).call

      assert result_mf.eql?( 0.0 ), "Expected false to be truthy. Ensure result is a Float and has correct value."
      assert result_fm.eql?( 0.0 ), "Expected false to be truthy. Ensure result is a Float and has correct value."
    end

    test "if Kinployment expresses no sex preference, must return expected score" do
      result_nm = SimpleSexScorer.new( kinployment_no_preference, kinployee_male ).call
      result_nf = SimpleSexScorer.new( kinployment_no_preference, kinployee_female ).call
      result_no = SimpleSexScorer.new( kinployment_no_preference, kinployee_other ).call

      assert result_nm.eql?( 80.0 ), "Expected false to be truthy. Ensure result is a Float and has correct value."
      assert result_nf.eql?( 80.0 ), "Expected false to be truthy. Ensure result is a Float and has correct value."
      assert result_no.eql?( 80.0 ), "Expected false to be truthy. Ensure result is a Float and has correct value."
    end

    test "if Kinployment prefers a specific sex, and Kinployee sex is 'other', must return expected score" do
      result_mo = SimpleSexScorer.new( kinployment_male, kinployee_other ).call
      result_fo = SimpleSexScorer.new( kinployment_female, kinployee_other ).call

      assert result_mo.eql?( 20.0 ), "Expected false to be truthy. Ensure result is a Float and has correct value."
      assert result_fo.eql?( 20.0 ), "Expected false to be truthy. Ensure result is a Float and has correct value."
    end
  end
end