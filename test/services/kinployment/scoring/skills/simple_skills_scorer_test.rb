require 'test_helper'

module Kinployment::Scoring::Skills
  class SimpleSkillsScorerTest < ActiveSupport::TestCase
    test "must return the percentage of Kinployment preferred skills that the Kinployee has" do
      kinployment = Kinployment.new( preferred_skills: ['one', 'two', 'three'] )
      kinployee_none  = Kinployee.new( skills: [] )
      kinployee_one   = Kinployee.new( skills: ['one'] )
      kinployee_two   = Kinployee.new( skills: ['one', 'two'] )
      kinployee_all   = Kinployee.new( skills: ['one', 'two', 'three'] )

      assert_in_delta 0.0,
                      SimpleSkillsScorer.new( kinployment, kinployee_none ).call,
                      0.000001
      assert_in_delta 1.0 / 3,
                      SimpleSkillsScorer.new( kinployment, kinployee_one ).call,
                      0.000001
      assert_in_delta 2.0 / 3,
                      SimpleSkillsScorer.new( kinployment, kinployee_two ).call,
                      0.000001
      assert_in_delta 1.0,
                      SimpleSkillsScorer.new( kinployment, kinployee_all ).call,
                      0.000001
    end
  end
end