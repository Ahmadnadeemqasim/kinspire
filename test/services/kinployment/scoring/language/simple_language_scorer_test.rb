require 'test_helper'

module Kinployment::Scoring::Language
  class SimpleLanguageScorerTest < ActiveSupport::TestCase
    test "must return the percentage of Kinployment preferred SimpleLanguageScorerTest that the Kinployee speaks" do
      kinployment = Kinployment.new( preferred_languages: ['one', 'two', 'three'] )
      kinployee_none  = Kinployee.new( languages: [] )
      kinployee_one   = Kinployee.new( languages: ['one'] )
      kinployee_two   = Kinployee.new( languages: ['one', 'two'] )
      kinployee_all   = Kinployee.new( languages: ['one', 'two', 'three'] )
      subject = SimpleLanguageScorer.new( kinployment )

      assert_in_delta 0.0,
                      subject.score_for( kinployee_none ),
                      0.000001
      assert_in_delta 1.0 / 3,
                      subject.score_for( kinployee_one ),
                      0.000001
      assert_in_delta 2.0 / 3,
                      subject.score_for( kinployee_two ),
                      0.000001
      assert_in_delta 1.0,
                      subject.score_for( kinployee_all ),
                      0.000001
    end
  end
end