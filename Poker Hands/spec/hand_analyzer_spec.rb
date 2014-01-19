require_relative '../lib/hand'
require_relative '../lib/card'
require_relative '../lib/hand_analyzer'

module PokerHandsKata
  describe "HandAnalyzer" do
    describe "analyze" do
      context "StraightFlush" do
        it "should return HandCategory instance of StraightFlush and value of largest card" do
          hand = Hand.new "6C 5C 7C 8C 9C"
          categories = HandAnalyzer.analyze hand
          categories.size.should == 1
          categories[0].name.should == HandCategory::STRAIGHT_FLUSH
          categories[0].highest_value.should == 9
        end
      end

      context "FourOfAKind" do
        xit "should return HandCategory instance of FourOfAKind and value of the card" do
          hand = Hand.new "7C 8C 7D 7S 7H"
          result = HandAnalyzer.analyze hand
          result.category.should == HandCategory::FOUR_OF_A_KIND
          result.highest_value.should == 7
        end
      end
    end
  end

  describe "category rules" do
    describe "StraightFlushRule" do
      describe "check" do
        it "should return a HandCategory instance of straight flush if matches" do
          card1 = Card.from_string "5C"
          card2 = Card.from_string "6C"
          card3 = Card.from_string "7C"
          card4 = Card.from_string "8C"
          card5 = Card.from_string "9C"

          cards = [card1, card2, card3, card4, card5]

          category = HandAnalyzer::StraightFlushRule.check cards
          category.name.should == HandCategory::STRAIGHT_FLUSH
          category.highest_value.should == "9"
        end

        it "should return nil if doesn't match" do
          card1 = Card.from_string "5C"
          card2 = Card.from_string "6D"
          card3 = Card.from_string "TC"
          card4 = Card.from_string "JC"
          card5 = Card.from_string "AC"

          cards = [card1, card2, card3, card4, card5]

          category = HandAnalyzer::StraightFlushRule.check cards
          category.should be nil
        end
      end
    end
  end
end
