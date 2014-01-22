module PokerHandsKata
  class HandAnalysisResult
    attr_reader :category, :remaining_cards

    def initialize(category, remaining_cards)
      @category = category
      @remaining_cards = remaining_cards
    end
  end
end
