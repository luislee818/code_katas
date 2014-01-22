require_relative 'hand_analysis_rules'

module PokerHandsKata

  class HandAnalyzer
    HAND_CATEGORY_RULES = [
      HandAnalysisRules::StraightFlushRule,
      HandAnalysisRules::FourOfAKindRule,
      HandAnalysisRules::FullHouseRule,
      HandAnalysisRules::FlushRule,
      HandAnalysisRules::StraightRule,
      HandAnalysisRules::ThreeOfAKindRule,
      HandAnalysisRules::TwoPairsRule,
      HandAnalysisRules::PairRule,
      HandAnalysisRules::HighCardRule,
      HandAnalysisRules::HighCardRule,
      HandAnalysisRules::HighCardRule,
      HandAnalysisRules::HighCardRule,
      HandAnalysisRules::HighCardRule
    ]

    def self.analyze(hand)
      cards = hand.cards.sort do |c1, c2|
        c1.score_value <=> c2.score_value
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

    def self.compare(left_categories, right_categories)
      loop do
        left_category = left_categories.shift
        right_category = right_categories.shift

        if left_category.nil? and right_category.nil?
          return 0
        elsif left_category.nil?
          return -1
        elsif right_category.nil?
          return 1
        else
          score_value_comparison = left_category.score_value <=> right_category.score_value

          if score_value_comparison == 0
            next
          else
            return score_value_comparison
          end
        end
      end
    end
  end
end
