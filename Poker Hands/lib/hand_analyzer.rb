require_relative 'hand_analysis_rules'

module PokerHandsKata

  class HandAnalyzer
    HAND_CATEGORY_RULES = [
      HandAnalysisRules::StraightFlushRule,
      HandAnalysisRules::FourOfAKindRule,
      HandAnalysisRules::HighCardRule
    ]

    def self.analyze(hand)
      cards = hand.cards.sort do |c1, c2|
        c1.value <=> c2.value
      end

      categories = []

      HAND_CATEGORY_RULES.each do |rule|
        break if cards.empty?

        result = rule.check(cards)

        if result
          categories << result.category
          cards = result.remaining_cards
          next
        end
      end

      categories
    end
  end
end
