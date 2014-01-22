require_relative '../lib/hand'
require_relative '../lib/card'
require_relative '../lib/hand_analyzer'
require_relative '../lib/hand_category'

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
        xit "should return an array containing a full house" do
          hand = Hand.new "AD 5C AS AH 5H"
          categories = HandAnalyzer.analyze hand
          categories.size.should == 1
          categories[0].name.should == HandCategory::FULL_HOUSE
          categories[0].highest_value.should == 14 * 1
        end
      end
    end
  end
end
