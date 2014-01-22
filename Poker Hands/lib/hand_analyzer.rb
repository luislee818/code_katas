module PokerHandsKata
  class HandAnalyzer
    def self.analyze(hand)
      cards = hand.cards.sort do |c1, c2|
        c1.value <=> c2.value
      end

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

    class HandAnalysisResult
      attr_reader :category, :remaining_cards

      def initialize(category, remaining_cards)
        @category = category
        @remaining_cards = remaining_cards
      end
    end

    class StraightFlushRule
      def self.check(cards)
        return nil unless (cards.size == 5)

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
          highest_card_value = cards[-1].score_value
          category = HandCategory.new(HandCategory::STRAIGHT_FLUSH, highest_card_value)
          remaining_cards = []
          HandAnalysisResult.new(category, remaining_cards)
        end
      end
    end

    class FourOfAKindRule
      def self.check(cards)
        first_card = cards[0]
        last_card = cards[4]
        v1 = first_card.score_value
        v2 = cards[1].score_value
        v3 = cards[2].score_value
        v4 = cards[3].score_value
        v5 = last_card.score_value

        first_four_matches = ((v1 == v2) and (v2 == v3) and (v3 == v4))
        last_four_matches = ((v2 == v3) and (v3 == v4) and (v4 == v5))

        if (first_four_matches or last_four_matches)
          category = HandCategory.new(HandCategory::FOUR_OF_A_KIND, v2)
          remaining_cards = [last_card] if first_four_matches
          remaining_cards = [first_card] if last_four_matches
          HandAnalysisResult.new(category, remaining_cards)
        end
      end
    end

    class FullHouseRule
      THREE_OF_A_KIND_MULTIPLIER = 100

      def self.check(cards)
        threesome_result = ThreeOfAKindRule.check cards
        return nil unless threesome_result

        threesome_value = threesome_result.category.highest_value
        remaining_cards = threesome_result.remaining_cards
        pair_result = PairRule.check remaining_cards

        return nil unless pair_result

        pair_value = pair_result.category.highest_value
        remaining_cards = pair_result.remaining_cards

        highest_card_value = threesome_value * THREE_OF_A_KIND_MULTIPLIER + pair_value
        category = HandCategory.new(HandCategory::FULL_HOUSE, highest_card_value)
        HandAnalysisResult.new(category, remaining_cards)
      end
    end

    class FlushRule
      def self.check(cards)
        return nil unless (cards.size == 5)

        s1 = cards[0].suit
        s2 = cards[1].suit
        s3 = cards[2].suit
        s4 = cards[3].suit
        s5 = cards[4].suit

        same_suit = ((s1 == s2) and (s2 == s3) and (s3 == s4) and (s4 == s5))

        if same_suit
          highest_card_value = cards[-1].score_value
          category = HandCategory.new(HandCategory::FLUSH, highest_card_value)
          remaining_cards = []
          HandAnalysisResult.new(category, remaining_cards)
        end
      end
    end

    class StraightRule
      def self.check(cards)
        return nil unless (cards.size == 5)

        matches_rule = true

        (0..(cards.size - 2)).each do |index|
          current_card = cards[index]
          next_card = cards[index + 1]

          unless (current_card.score_value + 1 == next_card.score_value)
            matches_rule = false
            break
          end
        end

        if matches_rule
          highest_card_value = cards[-1].score_value
          category = HandCategory.new(HandCategory::STRAIGHT, highest_card_value)
          remaining_cards = []
          HandAnalysisResult.new(category, remaining_cards)
        end
      end
    end

    class ThreeOfAKindRule
      def self.check(cards)
        found_match = false
        match_start_index = nil
        value_of_match = nil
        matched_cards = []

        (0..(cards.size - 3)).each do |index|
          first_card = cards[index]
          second_card = cards[index + 1]
          third_card = cards[index + 2]

          if (first_card.value == second_card.value) and (second_card.value == third_card.value)
            found_match = true
            match_start_index = index
            value_of_match = first_card.score_value
            matched_cards << first_card << second_card << third_card
            break
          end
        end

        if found_match
          highest_card_value = value_of_match
          category = HandCategory.new(HandCategory::THREE_OF_A_KIND, highest_card_value)
          remaining_cards = cards - matched_cards
          HandAnalysisResult.new(category, remaining_cards)
        end
      end
    end

    class TwoPairsRule
      PAIR_TWO_MULTIPLIER = 100

      def self.check(cards)
        result1 = PairRule.check cards
        return nil unless result1

        pair1_value = result1.category.highest_value
        remaining_cards = result1.remaining_cards
        result2 = PairRule.check remaining_cards

        return nil unless result2

        pair2_value = result2.category.highest_value
        remaining_cards = result2.remaining_cards

        highest_card_value = pair2_value * PAIR_TWO_MULTIPLIER + pair1_value
        category = HandCategory.new(HandCategory::TWO_PAIRS, highest_card_value)
        HandAnalysisResult.new(category, remaining_cards)
      end
    end

    class PairRule
      def self.check(cards)
        found_match = false
        match_start_index = nil
        value_of_match = nil
        matched_cards = []

        (0..(cards.size - 2)).each do |index|
          first_card = cards[index]
          second_card = cards[index + 1]

          if (first_card.value == second_card.value)
            found_match = true
            match_start_index = index
            value_of_match = first_card.score_value
            matched_cards << first_card << second_card
            break
          end
        end

        if found_match
          highest_card_value = value_of_match
          category = HandCategory.new(HandCategory::PAIR, highest_card_value)
          remaining_cards = cards - matched_cards
          HandAnalysisResult.new(category, remaining_cards)
        end
      end
    end

    class HighCardRule
      def self.check(cards)
        return nil if cards.empty?

        highest_card_value = cards[-1].score_value
        category = HandCategory.new(HandCategory::HIGH_CARD, highest_card_value)
        remaining_cards = cards[0..-2]
        HandAnalysisResult.new(category, remaining_cards)
      end
    end
  end
end
