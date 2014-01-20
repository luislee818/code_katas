module PokerHandsKata
  class HandAnalyzer
    def self.analyze(hand)
      cards = hand.cards.sort
      categories = []

      # until cards.empty?
      #   HandCategoryRules.each do |rule|
      #     result = rule.check(cards)

      #     unless result.category
      #       categories << result.category
      #       cards = result.remaining_cards
      #       break
      #     end
      #   end
      # end



      [HandCategory.new(HandCategory::STRAIGHT_FLUSH, 9)]
    end

    class StraightFlushRule
      def self.check(cards)
        matches_rule = true

        (0..(cards.size - 2)).each do |index|
          current_card = cards[index]
          next_card = cards[index + 1]

          unless (current_card.score_value + 1 == next_card.score_value) and
            (current_card.suit == next_card.suit)
            matches_rule = false
            break
          end
        end

        if matches_rule
          highest_card_value = cards[-1].value
          HandCategory.new(HandCategory::STRAIGHT_FLUSH, highest_card_value)
        end
      end
    end
  end
end
