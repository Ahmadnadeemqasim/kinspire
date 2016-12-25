require 'test_helper'

class NominationListTest < ActiveSupport::TestCase

  test "array-like interface" do
    kinployment = Kinployment.new
    subject = Kinployment::NominationList.new( kinployment )
    analogous_array = [
      Kinployment::Nomination.new( kinployment, Kinployee.new, { overall: 50.0 } ),
      Kinployment::Nomination.new( kinployment, Kinployee.new, { overall: 50.0 } ),
      Kinployment::Nomination.new( kinployment, Kinployee.new, { overall: 50.0 } )
    ]
    
    ##
    # #<<

    assert_nothing_raised do
      subject << analogous_array[0]
      subject << analogous_array[1]
      subject << analogous_array[2]
    end

    ##
    # #[]

    assert_equal analogous_array[0], subject[0]
    assert_equal analogous_array[1], subject[1]
    assert_equal analogous_array[2], subject[2]

    ##
    # #each
    # Using any iterator method from Enumerable should confirm #each works.

    subject.each do |nomination|
      assert_equal Kinployment::Nomination, nomination.class
    end
  end
end