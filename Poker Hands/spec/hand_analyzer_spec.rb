require_relative '../lib/hand'
require_relative '../lib/card'
require_relative '../lib/hand_analyzer'
require_relative '../lib/hand_category'
require_relative '../lib/hand_analysis_rules'

module PokerHandsKata
  describe "HandAnalyzer" do
    let(:straight_flush_hand) { Hand.new "6C 5C 7C 8C 9C" }
    let(:four_of_a_kind_hand) { Hand.new "6D 5C 6S 6H 6C" }
    let(:full_house_hand) { Hand.new "AD 5C AS AH 5H" }
    let(:flush_hand) { Hand.new "TH 4H KH 5H 9H" }
    let(:straight_hand) { Hand.new "4H 6S 5D 8H 7C" }
    let(:three_of_a_kind_hand) { Hand.new "4H 6S QD 6H 6C" }
    let(:two_pairs_hand) { Hand.new "8H JC 4C 8S 4H" }
    let(:one_pair_hand) { Hand.new "5H 9C KH 3C KS" }
    let(:all_high_cards_hand) { Hand.new "5H 9C KH 3C 2S" }

    describe "analyze" do
      context "A hand of straight flush" do
        it "should return an array containing a StraightFlush" do
          categories = HandAnalyzer.analyze straight_flush_hand
          categories.size.should == 1
          categories[0].name.should == HandCategory::STRAIGHT_FLUSH
          categories[0].highest_value.should == 9
        end
      end

      context "A hand of four of a kind and a high card" do
        it "should return an array containing a FourOfAKind and a HighCard" do
          categories = HandAnalyzer.analyze four_of_a_kind_hand
          categories.size.should == 2
          categories[0].name.should == HandCategory::FOUR_OF_A_KIND
          categories[0].highest_value.should == 6
          categories[1].name.should == HandCategory::HIGH_CARD
          categories[1].highest_value.should == 5
        end
      end

      context "A hand of full house" do
        it "should return an array containing a FullHouse" do
          categories = HandAnalyzer.analyze full_house_hand
          categories.size.should == 1
          categories[0].name.should == HandCategory::FULL_HOUSE
          categories[0].highest_value.should == 14 * HandAnalysisRules::FullHouseRule::THREE_OF_A_KIND_MULTIPLIER + 5
        end
      end

      context "A hand of flush" do
        it "should return an array containing a Flush" do
          categories = HandAnalyzer.analyze flush_hand
          categories.size.should == 1
          categories[0].name.should == HandCategory::FLUSH
          categories[0].highest_value.should == 13
        end
      end

      context "A hand of straight" do
        it "should return an array containing a Straight" do
          categories = HandAnalyzer.analyze straight_hand
          categories.size.should == 1
          categories[0].name.should == HandCategory::STRAIGHT
          categories[0].highest_value.should == 8
        end
      end

      context "A hand of three of a kind and two high cards" do
        it "should return an array containing a ThreeOfAKind and two HighCards" do
          categories = HandAnalyzer.analyze three_of_a_kind_hand
          categories.size.should == 3
          categories[0].name.should == HandCategory::THREE_OF_A_KIND
          categories[0].highest_value.should == 6
          categories[1].name.should == HandCategory::HIGH_CARD
          categories[1].highest_value.should == 12
          categories[2].name.should == HandCategory::HIGH_CARD
          categories[2].highest_value.should == 4
        end
      end

      context "A hand of two pairs and one high card" do
        it "should return an array containing a TwoPairs and one HighCard" do
          categories = HandAnalyzer.analyze two_pairs_hand
          categories.size.should == 2
          categories[0].name.should == HandCategory::TWO_PAIRS
          categories[0].highest_value.should == 8 * HandAnalysisRules::TwoPairsRule::PAIR_TWO_MULTIPLIER + 4
          categories[1].name.should == HandCategory::HIGH_CARD
          categories[1].highest_value.should == 11
        end
      end

      context "A hand of one pair and three high cards" do
        it "should return an array containing one Pair and two HighCards" do
          categories = HandAnalyzer.analyze one_pair_hand
          categories.size.should == 4
          categories[0].name.should == HandCategory::PAIR
          categories[0].highest_value.should == 13
          categories[1].name.should == HandCategory::HIGH_CARD
          categories[1].highest_value.should == 9
          categories[2].name.should == HandCategory::HIGH_CARD
          categories[2].highest_value.should == 5
          categories[3].name.should == HandCategory::HIGH_CARD
          categories[3].highest_value.should == 3
        end
      end

      context "A hand of five high cards" do
        it "should return an array containing five HighCards" do
          categories = HandAnalyzer.analyze all_high_cards_hand
          categories.size.should == 5
          categories[0].name.should == HandCategory::HIGH_CARD
          categories[0].highest_value.should == 13
          categories[1].name.should == HandCategory::HIGH_CARD
          categories[1].highest_value.should == 9
          categories[2].name.should == HandCategory::HIGH_CARD
          categories[2].highest_value.should == 5
          categories[3].name.should == HandCategory::HIGH_CARD
          categories[3].highest_value.should == 3
          categories[4].name.should == HandCategory::HIGH_CARD
          categories[4].highest_value.should == 2
        end
      end
    end

    describe "compare" do
      context "categories of left hand is larger than categories of right hand" do
        context "comparing straight flush to four of a kind" do
          it "should return 1" do
            left_categories = HandAnalyzer.analyze straight_flush_hand
            right_categories = HandAnalyzer.analyze four_of_a_kind_hand

            result = HandAnalyzer.compare(left_categories, right_categories)
            result.should == 1
          end
        end

        context "comparing four of a kind to full house" do
          it "should return 1" do
            left_categories = HandAnalyzer.analyze four_of_a_kind_hand
            right_categories = HandAnalyzer.analyze full_house_hand

            result = HandAnalyzer.compare(left_categories, right_categories)
            result.should == 1
          end
        end

        context "comparing full house to flush" do
          it "should return 1" do
            left_categories = HandAnalyzer.analyze full_house_hand
            right_categories = HandAnalyzer.analyze flush_hand

            result = HandAnalyzer.compare(left_categories, right_categories)
            result.should == 1
          end
        end

        context "comparing flush to straight" do
          it "should return 1" do
            left_categories = HandAnalyzer.analyze flush_hand
            right_categories = HandAnalyzer.analyze straight_hand

            result = HandAnalyzer.compare(left_categories, right_categories)
            result.should == 1
          end
        end

        context "comparing straight to three of a kind" do
          it "should return 1" do
            left_categories = HandAnalyzer.analyze straight_hand
            right_categories = HandAnalyzer.analyze three_of_a_kind_hand

            result = HandAnalyzer.compare(left_categories, right_categories)
            result.should == 1
          end
        end

        context "comparing three of a kind to two pairs" do
          it "should return 1" do
            left_categories = HandAnalyzer.analyze three_of_a_kind_hand
            right_categories = HandAnalyzer.analyze two_pairs_hand

            result = HandAnalyzer.compare(left_categories, right_categories)
            result.should == 1
          end
        end

        context "comparing two pairs to one pair" do
          it "should return 1" do
            left_categories = HandAnalyzer.analyze two_pairs_hand
            right_categories = HandAnalyzer.analyze one_pair_hand

            result = HandAnalyzer.compare(left_categories, right_categories)
            result.should == 1
          end
        end

        context "comparing one pair to all high cards" do
          it "should return 1" do
            left_categories = HandAnalyzer.analyze one_pair_hand
            right_categories = HandAnalyzer.analyze all_high_cards_hand

            result = HandAnalyzer.compare(left_categories, right_categories)
            result.should == 1
          end
        end
      end

      context "categories of left hand is smaller than categories of right hand" do
        it "should return -1" do
          left_categories  = HandAnalyzer.analyze four_of_a_kind_hand
          right_categories = HandAnalyzer.analyze straight_flush_hand

          result = HandAnalyzer.compare(left_categories, right_categories)
          result.should == -1
        end
      end

      context "categories of left hand tie with categories of right hand" do
        it "should return 0" do
          left_categories  = HandAnalyzer.analyze four_of_a_kind_hand
          right_categories = HandAnalyzer.analyze four_of_a_kind_hand

          result = HandAnalyzer.compare(left_categories, right_categories)
          result.should == 0
        end
      end
    end
  end
end
