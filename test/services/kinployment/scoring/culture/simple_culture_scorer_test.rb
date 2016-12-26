require 'test_helper'

module Kinployment::Scoring::Culture
  class SimpleCultureScorerTest < ActiveSupport::TestCase
    # Test Kinployment has 3 total backgrounds.
    # Test Kinployee has 4 total backgrounds.
    # Parties share 2 common backgrounds.

    ##
    # Kinployments

    def kinployment_no_preference
      Kinployment.new(  culture_match_preference: 'no_preference',
                        cultural_backgrounds: [ 'one', 'two', 'three' ] )
    end

    def kinployment_prefers_similar
      Kinployment.new(  culture_match_preference: 'similar',
                        cultural_backgrounds: [ 'one', 'two', 'three' ] )
    end

    def kinployment_prefers_dissimilar
      Kinployment.new(  culture_match_preference: 'not_similar',
                        cultural_backgrounds: [ 'one', 'two', 'three' ] )
    end

    def expected_kinployment_similarity_score
      # Expected score is ( number of common backgrounds / number of own backgrounds )
      ( 2.0 / 3 )
    end

    def expected_kinployment_dissimilarity_score
      # Expected score is ( 1 - expected similarity score )
      1 - ( 2.0 / 3 )
    end

    ##
    # Kinployees

    def kinployee_no_preference
      Kinployee.new(  culture_match_preference: 'no_preference',
                      cultural_backgrounds: [ 'two', 'three', 'four', 'five' ] )
    end

    def kinployee_prefers_similar
      Kinployee.new(  culture_match_preference: 'similar',
                      cultural_backgrounds: [ 'two', 'three', 'four', 'five' ] )
    end

    def kinployee_prefers_dissimilar
      Kinployee.new(  culture_match_preference: 'not_similar',
                      cultural_backgrounds: [ 'two', 'three', 'four', 'five' ] )
    end

    def expected_kinployee_similarity_score
      # Expected score is ( number of common backgrounds / number of own backgrounds )
      ( 2.0 / 4 )
    end

    def expected_kinployee_dissimilarity_score
      # Expected score is ( 1 - expected similarity score )
      1 - ( 2.0 / 4 )
    end

    ##
    # Tests

    test "when both parties express no preference, must return the expected score" do
      assert_in_delta 1.0,
                      SimpleCultureScorer.new(
                        kinployment_no_preference,
                        kinployee_no_preference ).call,
                      0.000001
    end

    test "when one party expresses no preference and the other party prefers similarity,\
          must return the expected score" do
      assert_in_delta expected_kinployee_similarity_score,
                      SimpleCultureScorer.new(
                        kinployment_no_preference,
                        kinployee_prefers_similar ).call,
                      0.000001
      assert_in_delta expected_kinployment_similarity_score,
                      SimpleCultureScorer.new(
                        kinployment_prefers_similar,
                        kinployee_no_preference ).call,
                      0.000001
    end

    test "when one party expresses no preference and the other party prefers dissimilarity,\
          must return the expected score" do
      assert_in_delta expected_kinployee_dissimilarity_score,
                      SimpleCultureScorer.new(
                        kinployment_no_preference,
                        kinployee_prefers_dissimilar ).call,
                      0.000001
      assert_in_delta expected_kinployment_dissimilarity_score,
                      SimpleCultureScorer.new(
                        kinployment_prefers_dissimilar,
                        kinployee_no_preference ).call,
                      0.000001
    end

    test "when one party prefers similarity and the other party prefers dissimilarity,\
          must return the expected score" do
      assert_in_delta expected_kinployment_similarity_score * expected_kinployee_dissimilarity_score,
                      SimpleCultureScorer.new(
                        kinployment_prefers_similar,
                        kinployee_prefers_dissimilar ).call,
                      0.000001
      assert_in_delta expected_kinployment_dissimilarity_score * expected_kinployee_similarity_score,
                      SimpleCultureScorer.new(
                        kinployment_prefers_dissimilar,
                        kinployee_prefers_similar ).call,
                      0.000001
    end

    test "when both parties prefer similarity, must return the expected score" do
      assert_in_delta expected_kinployment_similarity_score * expected_kinployee_similarity_score,
                      SimpleCultureScorer.new(
                        kinployment_prefers_similar,
                        kinployee_prefers_similar ).call,
                      0.000001
    end

    test "when both parties prefer dissimilarity, must return the expected score" do
      assert_in_delta expected_kinployment_dissimilarity_score * expected_kinployee_dissimilarity_score,
                      SimpleCultureScorer.new(
                        kinployment_prefers_dissimilar,
                        kinployee_prefers_dissimilar ).call,
                      0.000001
    end
  end
end