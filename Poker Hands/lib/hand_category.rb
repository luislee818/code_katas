module PokerHandsKata
  class HandCategory
    STRAIGHT_FLUSH = :STRAIGHT_FLUSH
    FOUR_OF_A_KIND = :FOUR_OF_A_KIND
    FLUSH = :FLUSH
    STRAIGHT = :STRAIGHT
    THREE_OF_A_KIND = :THREE_OF_A_KIND

    attr_reader :name, :highest_value

    def initialize(name, highest_value)
      @name = name
      @highest_value = highest_value
    end
  end
end
