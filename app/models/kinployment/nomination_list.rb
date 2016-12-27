require 'forwardable'

class Kinployment

  ##
  # A list of Nominations for a given Kinployment.

  class NominationList
    include Enumerable

    attr_reader :kinployment

    ##
    # Constructor.

    def initialize( kinployment, nominations=[] )
      @kinployment = kinployment
      @nominations = nominations
    end

    ##
    # Set up desired array-like interface.
    
    extend Forwardable
    def_delegators :@nominations,
      :[],
      :<<,
      :each,  # #each enables all other Enumerable methods.
      :length

    ##
    # Sorts this instance in place, in descending order.
    # Returns this NominationList.

    def sort!
      @nominations.sort!
      @nominations.reverse!
      return self
    end
  end
end