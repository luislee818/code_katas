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

    CATEGORY_SCORE_VALUES = {
      STRAIGHT_FLUSH: 9,
      FOUR_OF_A_KIND: 8,
      FULL_HOUSE: 7,
      FLUSH: 6,
      STRAIGHT: 5,
      THREE_OF_A_KIND: 4,
      TWO_PAIRS: 3,
      PAIR: 2,
      HIGH_CARD: 1
    }

    attr_reader :name, :highest_value, :score_value

    def initialize(name, highest_value)
      @name = name
      @highest_value = highest_value
      @score_value = CATEGORY_SCORE_VALUES[name]
    end
  end
end
