module PokerHandsKata
  class Card
    include Comparable

    attr_reader :suit, :value, :score_value

    CLUB = :CLUB
    SPADE = :SPADE
    DIAMOND = :DIAMOND
    HEART = :HEART
    SUITS = {
      "C" => CLUB,
      "S" => SPADE,
      "D" => DIAMOND,
      "H" => HEART
    }

    def self.from_string(str)
      value_char = str[0]
      suit_char = str[1]

      self.new(value_char, SUITS[suit_char])
    end

    def <=>(other)
      self.score_value <=> other.score_value
    end

    private
    def initialize(value, suit)
      @value = value
      @suit = suit

      @score_value = case value
                     when "A" then 14
                     when "K" then 13
                     when "Q" then 12
                     when "J" then 11
                     when "T" then 10
                     else value.to_i
                     end
    end
  end
end
