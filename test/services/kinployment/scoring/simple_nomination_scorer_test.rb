require 'test_helper'

class SimpleNominationScorerTest < ActiveSupport::TestCase
  SimpleNominationScorer = ::Kinployment::Scoring::SimpleNominationScorer

  def setup
    @kinployment = Kinployment.new( preferred_availability: 20,
                                    culture_match_preference: 'no_preference',
                                    cultural_backgrounds: ['one', 'two', 'three'],
                                    preferred_languages: ['one', 'two', 'three'],
                                    location: { city: 'San Francisco', state: 'CA' },
                                    preferred_sex: 'no_preference',
                                    preferred_skills: ['one', 'two', 'three']
                                    )
    @kinployee = Kinployee.new( availability: 21,
                                culture_match_preference: 'no_preference',
                                cultural_backgrounds: ['two', 'three', 'four', 'five'],
                                languages: ['one', 'two'],
                                location: { city: 'San Francisco', state: 'CA' },
                                sex: 'male',
                                skills: ['one', 'two']
                                )
  end

  test "must return a Hash of scores" do
    result = SimpleNominationScorer.new( @kinployment ).score_for( @kinployee )

    assert_equal  Hash, result.class             
  end

  test "must calculate overall score of 0.0 if Kinployee does not have enough availability" do
    @kinployee.availability = @kinployment.preferred_availability - 1

    result = SimpleNominationScorer.new( @kinployment ).score_for( @kinployee )

    assert result[:overall].eql?( 0.0 ), "Unexpected value: #{result[:overall]}. Ensure result is a Float and has correct value."
  end

  test "must calculate overall score of 0.0 if Kinployee does not have the right skills" do
    @kinployee.skills = @kinployee.skills - @kinployment.preferred_skills

    result = SimpleNominationScorer.new( @kinployment ).score_for( @kinployee )

    assert result[:overall].eql?( 0.0 ), "Unexpected value: #{result[:overall]}. Ensure result is a Float and has correct value."
  end

  test "must calculate average value of all scores when Kinployee is available and has applicable skills" do
    result = SimpleNominationScorer.new( @kinployment ).score_for( @kinployee )
    subscores = result.reject { |k, v| k == :overall }

    assert_not_equal 0.0, result[:overall], "Expected non-zero value instead of #{result[:overall]}"
    assert_in_delta subscores.values.reduce( :+ ) / subscores.length,
                    result[:overall],
                    0.000001
  end
end