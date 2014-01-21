require_relative '../lib/hand'
require_relative '../lib/card'
require_relative '../lib/hand_analyzer'
require_relative '../lib/hand_category'

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
    end
  end

  describe "category rules" do
    describe "StraightFlushRule" do
      describe "check" do
        context "5 cards of straight flush" do
          it "should return a HandAnalysisResult object with HandCategory being straight flush and remaining cards of empty array" do
            card1 = Card.from_string "5C"
            card2 = Card.from_string "6C"
            card3 = Card.from_string "7C"
            card4 = Card.from_string "8C"
            card5 = Card.from_string "9C"

            cards = [card1, card2, card3, card4, card5]

            result = HandAnalyzer::StraightFlushRule.check cards
            result.category.name.should == HandCategory::STRAIGHT_FLUSH
            result.category.highest_value.should == "9"
            result.remaining_cards.should == []
          end
        end

        context "cards are not straight flush" do
          it "should return nil" do
            card1 = Card.from_string "5C"
            card2 = Card.from_string "6D"
            card3 = Card.from_string "TC"
            card4 = Card.from_string "JC"
            card5 = Card.from_string "AC"

            cards = [card1, card2, card3, card4, card5]

            result = HandAnalyzer::StraightFlushRule.check cards
            result.should be nil
          end
        end

        context "card number less than 5" do
          it "should return nil" do
            card1 = Card.from_string "5C"
            card2 = Card.from_string "6C"
            card3 = Card.from_string "7C"
            card4 = Card.from_string "8C"

            cards = [card1, card2, card3, card4]

            result = HandAnalyzer::StraightFlushRule.check cards
            result.should be nil
          end
        end
      end
    end

    describe "FourOfAKindRule" do
      describe "check" do
        context "there are 4 cards of one kind" do
          it "should return a HandAnalysisResult object with HandCategory being four of a kind and remaining cards of the other one" do
            card1 = Card.from_string "6D"
            card2 = Card.from_string "6C"
            card3 = Card.from_string "6H"
            card4 = Card.from_string "6S"
            card5 = Card.from_string "AC"

            cards = [card1, card2, card3, card4, card5]

            result = HandAnalyzer::FourOfAKindRule.check cards
            result.category.name.should == HandCategory::FOUR_OF_A_KIND
            result.category.highest_value.should == "6"
            result.remaining_cards.size.should == 1
            result.remaining_cards.should include(card5)
          end
        end

        context "cards are not four of a kind" do
          it "should return nil" do
            card1 = Card.from_string "6D"
            card2 = Card.from_string "6C"
            card3 = Card.from_string "6H"
            card4 = Card.from_string "7S"
            card5 = Card.from_string "AC"

            cards = [card1, card2, card3, card4, card5]

            result = HandAnalyzer::FourOfAKindRule.check cards
            result.should be nil
          end
        end
      end
    end

    describe "FullHouseRule" do
      describe "check" do
        context "there are 3 cards of the same value, with the remaining 2 cards forming a pair" do
          # TODO: after implementing ThreeOfAKind and Pair
          xit "should return a HandAnalysisResult object with HandCategory being full house and remaining cards of empty array" do
            card1 = Card.from_string "6D"
            card2 = Card.from_string "6C"
            card3 = Card.from_string "6H"
            card4 = Card.from_string "AS"
            card5 = Card.from_string "AC"

            cards = [card1, card2, card3, card4, card5]

            result = HandAnalyzer::FullHouseRule.check cards
            result.category.name.should == HandCategory::FULL_HOUSE
            result.category.highest_value.should == "6"
            result.remaining_cards.should == []
          end
        end
      end
    end

    describe "FlushRule" do
      describe "check" do
        context "5 cards of the same suit" do
          it "should return a HandAnalysisResult object with HandCategory being flush and remaining cards of empty array" do
            card1 = Card.from_string "6D"
            card2 = Card.from_string "6D"
            card3 = Card.from_string "9D"
            card4 = Card.from_string "JD"
            card5 = Card.from_string "AD"

            cards = [card1, card2, card3, card4, card5]

            result = HandAnalyzer::FlushRule.check cards
            result.category.name.should == HandCategory::FLUSH
            result.category.highest_value.should == "A"
            result.remaining_cards.should == []
          end
        end

        context "5 cards are not the same suit" do
          it "should return nil" do
            card1 = Card.from_string "6D"
            card2 = Card.from_string "6D"
            card3 = Card.from_string "9S"
            card4 = Card.from_string "JD"
            card5 = Card.from_string "AD"

            cards = [card1, card2, card3, card4, card5]

            result = HandAnalyzer::FlushRule.check cards
            result.should be nil
          end
        end

        context "card number less than 5" do
          it "should return nil" do
            card1 = Card.from_string "6D"
            card2 = Card.from_string "6D"
            card3 = Card.from_string "9D"
            card4 = Card.from_string "AD"

            cards = [card1, card2, card3, card4]

            result = HandAnalyzer::FlushRule.check cards
            result.should be nil
          end
        end
      end
    end
  end
end
