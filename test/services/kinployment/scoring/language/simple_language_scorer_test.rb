require 'test_helper'

module Kinployment::Scoring::Language
  class SimpleLanguageScorerTest < ActiveSupport::TestCase
    test "must return the percentage of Kinployment preferred SimpleLanguageScorerTest that the Kinployee speaks" do
      kinployment = Kinployment.new( preferred_languages: ['one', 'two', 'three'] )
      kinployee_none  = Kinployee.new( languages: [] )
      kinployee_one   = Kinployee.new( languages: ['one'] )
      kinployee_two   = Kinployee.new( languages: ['one', 'two'] )
      kinployee_all   = Kinployee.new( languages: ['one', 'two', 'three'] )

      assert_in_delta 0.0,
                      SimpleLanguageScorer.new( kinployment, kinployee_none ).call,
                      0.0001
      assert_in_delta 100 * ( 1.0 / 3 ),
                      SimpleLanguageScorer.new( kinployment, kinployee_one ).call,
                      0.0001
      assert_in_delta 100 * ( 2.0 / 3 ),
                      SimpleLanguageScorer.new( kinployment, kinployee_two ).call,
                      0.0001
      assert_in_delta 100.0,
                      SimpleLanguageScorer.new( kinployment, kinployee_all ).call,
                      0.0001
    end
  end
end