require_relative 'card'

module PokerHandsKata
  class Hand
    attr_reader :cards

    def initialize(str)
      card_str_values = str.split
      @cards = []

      card_str_values.each do |str_value|
        @cards << Card.from_string(str_value)
      end
    end
  end
end
