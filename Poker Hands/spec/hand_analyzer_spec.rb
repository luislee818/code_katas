require_relative '../lib/hand'
require_relative '../lib/card'
require_relative '../lib/hand_analyzer'
require_relative '../lib/hand_category'
require_relative '../lib/hand_analysis_rules'

module PokerHandsKata
  describe "HandAnalyzer" do
    describe "analyze" do
      context "A hand of straight flush" do
        it "should return an array containing a StraightFlush" do
          hand = Hand.new "6C 5C 7C 8C 9C"
          categories = HandAnalyzer.analyze hand
          categories.size.should == 1
          categories[0].name.should == HandCategory::STRAIGHT_FLUSH
          categories[0].highest_value.should == 9
        end
      end

      context "A hand of four of a kind and a high card" do
        it "should return an array containing a FourOfAKind and a HighCard" do
          hand = Hand.new "6D 5C 6S 6H 6C"
          categories = HandAnalyzer.analyze hand
          categories.size.should == 2
          categories[0].name.should == HandCategory::FOUR_OF_A_KIND
          categories[0].highest_value.should == 6
          categories[1].name.should == HandCategory::HIGH_CARD
          categories[1].highest_value.should == 5
        end
      end

      context "A hand of full house" do
        it "should return an array containing a FullHouse" do
          hand = Hand.new "AD 5C AS AH 5H"
          categories = HandAnalyzer.analyze hand
          categories.size.should == 1
          categories[0].name.should == HandCategory::FULL_HOUSE
          categories[0].highest_value.should == 14 * HandAnalysisRules::FullHouseRule::THREE_OF_A_KIND_MULTIPLIER + 5
        end
      end

      context "A hand of flush" do
        it "should return an array containing a Flush" do
          hand = Hand.new "TH 4H KH 5H 9H"
          categories = HandAnalyzer.analyze hand
          categories.size.should == 1
          categories[0].name.should == HandCategory::FLUSH
          categories[0].highest_value.should == 13
        end
      end

      context "A hand of straight" do
        it "should return an array containing a Straight" do
          hand = Hand.new "4H 6S 5D 8H 7C"
          categories = HandAnalyzer.analyze hand
          categories.size.should == 1
          categories[0].name.should == HandCategory::STRAIGHT
          categories[0].highest_value.should == 8
        end
      end

      context "A hand of three of a kind and two high cards" do
        it "should return an array containing a ThreeOfAKind and two HighCards" do
          hand = Hand.new "4H 6S QD 6H 6C"
          categories = HandAnalyzer.analyze hand
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
          hand = Hand.new "8H JC 4C 8S 4H"
          categories = HandAnalyzer.analyze hand
          categories.size.should == 2
          categories[0].name.should == HandCategory::TWO_PAIRS
          categories[0].highest_value.should == 8 * HandAnalysisRules::TwoPairsRule::PAIR_TWO_MULTIPLIER + 4
          categories[1].name.should == HandCategory::HIGH_CARD
          categories[1].highest_value.should == 11
        end
      end

      context "A hand of one pair and three high cards" do
        it "should return an array containing one Pair and two HighCards" do
          hand = Hand.new "5H 9C KH 3C KS"
          categories = HandAnalyzer.analyze hand
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
          hand = Hand.new "5H 9C KH 3C 2S"
          categories = HandAnalyzer.analyze hand
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
  end
end
