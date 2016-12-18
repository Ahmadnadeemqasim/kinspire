require 'forwardable'

class Kinployment

  ##
  # A list of Nominations for a given Kinployment.

  class NominationList
    include Enumerable

    attr_reader :kinployment

    ##
    # Constructor.

    def initialize( kinployment )
      @kinployment = kinployment
      @nominations = []
    end

    ##
    # Set up desired array-like interface.
    
    extend Forwardable
    def_delegators :@nominations,
      :[],
      :<<,
      :each # #each enables all other Enumerable methods.
  end
end