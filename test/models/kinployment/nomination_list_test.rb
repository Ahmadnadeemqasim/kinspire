require 'test_helper'

class NominationListTest < ActiveSupport::TestCase
  Nomination = Kinployment::Nomination

  def setup
    @kinployment = Kinployment.new
    @analogous_array = [
      Nomination.new( @kinployment, Kinployee.new, { overall: 0.3 } ),
      Nomination.new( @kinployment, Kinployee.new, { overall: 0.0 } ),
      Nomination.new( @kinployment, Kinployee.new, { overall: 0.5 } ),
      ]
    @subject = Kinployment::NominationList.new( @kinployment, @analogous_array )
  end

  def new_nomination( overall_score=0.5 )
    Nomination.new( @kinployment, Kinployee.new, { overall: overall_score } )
  end

  ##
  # #<<

  test "#<< must add the given element to the end of the NominationList" do
    length_before = @subject.length

    assert_nothing_raised do
      @subject << new_nomination
    end
    assert_equal 1+length_before, @subject.length
    assert_equal @subject[-1], new_nomination
  end

  ##
  # #[]

  test "#[] must return the element at the indicated index, with Array-like syntax" do
    assert_equal @analogous_array[-1], @subject[-1]
    assert_equal @analogous_array[0],  @subject[0]
    assert_equal @analogous_array[1],  @subject[1]
  end

  ##
  # #each

  test "#each must iterate over the contained Nomination elements" do
    @subject.each do |n|
      assert_equal Nomination, n.class, "Expected #each to iterate over Nominations."
    end
  end

  test "#each must return an Enumerator if no block is given" do
    assert_equal Enumerator, @subject.each.class
  end

  ##
  # #length

  test "#length must return the number of elements in the NominationList" do
    assert_equal @analogous_array.length, @subject.length
  end

  ##
  # #sort!

  test "#sort! must sort the NominationList by overall score of the Nominations contained, with the highest score first" do
    subject = Kinployment::NominationList.new( @kinployment )
    unsorted_order = [0.3, 0.0, 0.5, 0.6, 0.1, 0.5]
    sorted_order   = [0.6, 0.5, 0.5, 0.3, 0.1, 0.0]
    unsorted_order.each{ |score| subject << new_nomination( score ) }

    subject.sort!
    result = subject.map{ |n| n.overall_score }

    assert_equal sorted_order, result
  end

  test "#sort! must return a NominationsList" do
    assert_equal Kinployment::NominationList, @subject.sort!.class
  end
end