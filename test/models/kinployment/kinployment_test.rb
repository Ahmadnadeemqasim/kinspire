require 'test_helper'

class KinploymentTest < ActiveSupport::TestCase

  ##
  # TODO: Please activate this test once Kinployment has been decoupled from validations.
  
  # test "cultural_backgrounds should serialize and deserialize as expected" do
  #   kinployment = Kinployment.new( cultural_backgrounds: [ 'one', 'two', 'three' ] )

  #   assert kinployment.save
  #   assert_equal  [ 'one', 'two', 'three' ],
  #                 kinployment.reload.cultural_backgrounds,
  #                 "Expected attribute to be deserialized into an Array of strings."
  # end

  ##
  # TODO: Please activate this test once Kinployment has been decoupled from validations.
  
  # test "preferred_skills should serialize and deserialize as expected" do
  #   kinployment = Kinployment.new( preferred_skills: [ 'one', 'two', 'three' ] )

  #   assert kinployment.save
  #   assert_equal  [ 'one', 'two', 'three' ],
  #                 kinployment.reload.preferred_skills,
  #                 "Expected attribute to be deserialized into an Array of strings."
  # end

  ##
  # TODO: Please activate this test once Kinployment has been decoupled from validations.
  
  # test "preferred_languages should serialize and deserialize as expected" do
  #   kinployment = Kinployment.new( preferred_languages: [ 'one', 'two', 'three' ] )

  #   assert kinployment.save
  #   assert_equal  [ 'one', 'two', 'three' ],
  #                 kinployment.reload.preferred_languages,
  #                 "Expected attribute to be deserialized into an Array of strings."
  # end

  ##
  # TODO: Please activate this test once Kinployment has been decoupled from validations.
  
  # test "location should serialize and deserialize as expected" do
  #   kinployment = Kinployment.new( location: { city: 'San Francisco', state: 'CA' } )

  #   assert kinployment.save
  #   # Note: Parentheses are necessary to indicate first argument is Hash object, not code block:
  #   assert_equal( { city: 'San Francisco', state: 'CA' },
  #                 kinployment.reload.location,
  #                 "Expected attribute to be deserialized into Hash of strings." )
  # end

  ##
  # #engage

  test "must associate the given Kinployee" do
    kinployment = Kinployment.new
    kinployee = Kinployee.new

    kinployment.engage( kinployee )

    assert_equal kinployee, kinployment.kinployee
  end

  test "must return the given Kinployment if successful" do
    kinployment = Kinployment.new
    kinployee = Kinployee.new

    assert_equal kinployee, kinployment.engage( kinployee )
  end

  test "must return false if the Kinployment is already engaged" do
    kinployment = Kinployment.new
    kinployment.engage( Kinployee.new )

    assert_not kinployment.engage( Kinployee.new )
  end

  ##
  # #engaged?

  test "must return true if the Kinployment has an associated Kinployee" do
    kinployment = Kinployment.new
    kinployment.engage( Kinployee.new )

    assert kinployment.engaged?
  end

  test "must return false if the Kinployment has no associated Kinployee" do
    kinployment = Kinployment.new
    kinployment.disengage

    assert_not kinployment.engaged?
  end

  ##
  # #disengage

  test "must remove the Kinployee association" do
    kinployment = Kinployment.new
    kinployee = Kinployee.new
    kinployment.engage( kinployee )

    result_before = kinployment.kinployee
    kinployment.disengage
    result_after = kinployment.kinployee

    assert_equal kinployee, result_before
    assert_equal nil, result_after
  end
end