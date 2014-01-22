module PokerHandsKata
  class HandCategory
    STRAIGHT_FLUSH = :STRAIGHT_FLUSH
    FOUR_OF_A_KIND = :FOUR_OF_A_KIND
    FULL_HOUSE = :FULL_HOUSE
    FLUSH = :FLUSH
    STRAIGHT = :STRAIGHT
    THREE_OF_A_KIND = :THREE_OF_A_KIND
    TWO_PAIRS = :TWO_PAIRS
    PAIR = :PAIR
    HIGH_CARD = :HIGH_CARD

    attr_reader :name, :highest_value

    def initialize(name, highest_value)
      @name = name
      @highest_value = highest_value
    end
  end
end
