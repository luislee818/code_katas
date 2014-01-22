require_relative '../lib/card'
require_relative '../lib/hand_category'
require_relative '../lib/hand_analysis_rules'

module PokerHandsKata
  module HandAnalysisRules
    describe "hand analysis rules" do
      describe "StraightFlushRule" do
        describe "check" do
          context "5 cards of straight flush" do
            it "should return a HandAnalysisResult object with HandCategory being straight flush and remaining cards of empty array" do
              card1 = Card.from_string "7C"
              card2 = Card.from_string "8C"
              card3 = Card.from_string "9C"
              card4 = Card.from_string "TC"
              card5 = Card.from_string "JC"

              cards = [card1, card2, card3, card4, card5]

              result = StraightFlushRule.check cards
              result.category.name.should == HandCategory::STRAIGHT_FLUSH
              result.category.highest_value.should == 11
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

              result = StraightFlushRule.check cards
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

              result = StraightFlushRule.check cards
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

              result = FourOfAKindRule.check cards
              result.category.name.should == HandCategory::FOUR_OF_A_KIND
              result.category.highest_value.should == 6
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

              result = FourOfAKindRule.check cards
              result.should be nil
            end
          end
        end
      end

      describe "FullHouseRule" do
        describe "check" do
          context "there are 3 cards of the same value, with the remaining 2 cards forming a pair" do
            it "should return a HandAnalysisResult object with HandCategory being full house and remaining cards of empty array" do
              card1 = Card.from_string "6D"
              card2 = Card.from_string "6C"
              card3 = Card.from_string "6H"
              card4 = Card.from_string "AS"
              card5 = Card.from_string "AC"

              cards = [card1, card2, card3, card4, card5]

              result = FullHouseRule.check cards
              result.category.name.should == HandCategory::FULL_HOUSE
              result.category.highest_value.should == 6 * FullHouseRule::THREE_OF_A_KIND_MULTIPLIER + 14
              result.remaining_cards.should == []
            end
          end

          context "5 cards are not full house" do
            it "should return nil" do
              card1 = Card.from_string "6D"
              card2 = Card.from_string "6C"
              card3 = Card.from_string "8H"
              card4 = Card.from_string "AS"
              card5 = Card.from_string "AC"

              cards = [card1, card2, card3, card4, card5]

              result = FullHouseRule.check cards
              result.should be nil
            end
          end

          context "card number less than 5" do
            it "should return nil" do
              card1 = Card.from_string "6D"
              card2 = Card.from_string "6C"
              card3 = Card.from_string "8H"
              card4 = Card.from_string "AS"

              cards = [card1, card2, card3, card4]

              result = FullHouseRule.check cards
              result.should be nil
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

              result = FlushRule.check cards
              result.category.name.should == HandCategory::FLUSH
              result.category.highest_value.should == 14
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

              result = FlushRule.check cards
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

              result = FlushRule.check cards
              result.should be nil
            end
          end
        end
      end

      describe "StraightRule" do
        describe "check" do
          context "5 cards with consecutive numbers" do
            it "should return a HandAnalysisResult object with HandCategory being straight and remaining cards of empty array" do
              card1 = Card.from_string "7C"
              card2 = Card.from_string "8D"
              card3 = Card.from_string "9H"
              card4 = Card.from_string "TD"
              card5 = Card.from_string "JD"

              cards = [card1, card2, card3, card4, card5]

              result = StraightRule.check cards
              result.category.name.should == HandCategory::STRAIGHT
              result.category.highest_value.should == 11
              result.remaining_cards.should == []
            end
          end

          context "5 cards not with consecutive numbers" do
            it "should return nil" do
              card1 = Card.from_string "7C"
              card2 = Card.from_string "8D"
              card3 = Card.from_string "9H"
              card4 = Card.from_string "TD"
              card5 = Card.from_string "AD"

              cards = [card1, card2, card3, card4, card5]

              result = StraightRule.check cards
              result.should be nil
            end
          end

          context "card number less than 5" do
            it "should return nil" do
              card1 = Card.from_string "7C"
              card2 = Card.from_string "8D"
              card3 = Card.from_string "9H"
              card4 = Card.from_string "TD"

              cards = [card1, card2, card3, card4]

              result = StraightRule.check cards
              result.should be nil
            end
          end
        end
      end

      describe "ThreeOfAKindRule" do
        describe "check" do
          context "3 cards with the same value out of 3 cards" do
            it "should return a HandAnalysisResult object with HandCategory being ThreeOfAKind and remaining cards being an empty array" do
              card1 = Card.from_string "7C"
              card2 = Card.from_string "7D"
              card3 = Card.from_string "7H"

              cards = [card1, card2, card3]

              result = ThreeOfAKindRule.check cards
              result.category.name.should == HandCategory::THREE_OF_A_KIND
              result.category.highest_value.should == 7
              result.remaining_cards.should == []
            end
          end

          context "3 cards with the same value out of more than 3 cards" do
            it "should return a HandAnalysisResult object with HandCategory being ThreeOfAKind and remaining cards being an empty array" do
              card1 = Card.from_string "7C"
              card2 = Card.from_string "7D"
              card3 = Card.from_string "7H"
              card4 = Card.from_string "9H"
              card5 = Card.from_string "JH"

              cards = [card1, card2, card3, card4, card5]

              result = ThreeOfAKindRule.check cards
              result.category.name.should == HandCategory::THREE_OF_A_KIND
              result.category.highest_value.should == 7
              result.remaining_cards.size.should == 2
              result.remaining_cards.should include(card4)
              result.remaining_cards.should include(card5)
            end
          end

          context "3 or more cards that do not have three of a kind" do
            it "should return nil" do
              card1 = Card.from_string "3C"
              card2 = Card.from_string "7D"
              card3 = Card.from_string "7H"
              card4 = Card.from_string "9H"
              card5 = Card.from_string "JH"

              cards = [card1, card2, card3, card4, card5]

              result = ThreeOfAKindRule.check cards
              result.should be nil
            end
          end

          context "card number less than 3" do
            it "should return nil" do
              card1 = Card.from_string "3C"
              card2 = Card.from_string "7D"

              cards = [card1, card2]

              result = ThreeOfAKindRule.check cards
              result.should be nil
            end
          end
        end
      end

      describe "TwoPairsRule" do
        describe "check" do
          context "cards contain two different pairs" do
            it "should return a HandAnalysisResult object with category being two pairs and appropriate remaining cards" do
              card1 = Card.from_string "7C"
              card2 = Card.from_string "7D"
              card3 = Card.from_string "9H"
              card4 = Card.from_string "AD"
              card5 = Card.from_string "AH"

              cards = [card1, card2, card3, card4, card5]

              result = TwoPairsRule.check cards
              result.category.name.should == HandCategory::TWO_PAIRS
              result.category.highest_value.should == (14 * TwoPairsRule::PAIR_TWO_MULTIPLIER + 7)
              result.remaining_cards.size.should == 1
              result.remaining_cards.should include(card3)
            end
          end

          context "cards do not contain two different pairs" do
            context "cards contain 1 pair only" do
              it "should return nil" do
                card1 = Card.from_string "2C"
                card2 = Card.from_string "7D"
                card3 = Card.from_string "7H"
                card4 = Card.from_string "JD"
                card5 = Card.from_string "AH"

                cards = [card1, card2, card3, card4, card5]

                result = TwoPairsRule.check cards
                result.should be nil
              end
            end

            context "cards contain no pairs" do
              it "should return nil" do
                card1 = Card.from_string "2C"
                card2 = Card.from_string "5D"
                card3 = Card.from_string "7H"
                card4 = Card.from_string "JD"
                card5 = Card.from_string "AH"

                cards = [card1, card2, card3, card4, card5]

                result = TwoPairsRule.check cards
                result.should be nil
              end
            end
          end
        end
      end

      describe "PairRule" do
        describe "check" do
          context "cards contain a pair" do
            it "should return a HandAnalysisResult object with category being pair and appropriate remaining cards" do
              card1 = Card.from_string "7C"
              card2 = Card.from_string "9D"
              card3 = Card.from_string "9H"
              card4 = Card.from_string "JD"
              card5 = Card.from_string "AH"

              cards = [card1, card2, card3, card4, card5]

              result = PairRule.check cards
              result.category.name.should == HandCategory::PAIR
              result.category.highest_value.should == 9
              result.remaining_cards.size.should == 3
              result.remaining_cards.should include(card1)
              result.remaining_cards.should include(card4)
              result.remaining_cards.should include(card5)
            end
          end

          context "cards do not contain a pair" do
            it "should return nil" do
              card1 = Card.from_string "7C"
              card2 = Card.from_string "9D"
              card3 = Card.from_string "TH"
              card4 = Card.from_string "JD"
              card5 = Card.from_string "AH"

              cards = [card1, card2, card3, card4, card5]

              result = PairRule.check cards
              result.should be nil
            end
          end

          context "only 1 card" do
            it "should return nil" do
              card1 = Card.from_string "7C"

              cards = [card1]

              result = PairRule.check cards
              result.should be nil
            end
          end
        end
      end

      describe "HighCardRule" do
        describe "check" do
          context "cards are not empty" do
            it "should return a HandAnalysisResult object with category being high card and appropriate remaining cards" do
              card1 = Card.from_string "7C"
              card2 = Card.from_string "9D"
              card3 = Card.from_string "TH"
              card4 = Card.from_string "JD"
              card5 = Card.from_string "AH"

              cards = [card1, card2, card3, card4, card5]

              result = HighCardRule.check cards
              result.category.name.should == HandCategory::HIGH_CARD
              result.category.highest_value.should == 14
              result.remaining_cards.size.should == 4
              result.remaining_cards.should include(card1)
              result.remaining_cards.should include(card2)
              result.remaining_cards.should include(card3)
              result.remaining_cards.should include(card4)
            end
          end

          context "cards are empty" do
            it "should return nil" do
              cards = []

              result = HighCardRule.check cards
              result.should be nil
            end
          end
        end
      end
    end
  end
end
