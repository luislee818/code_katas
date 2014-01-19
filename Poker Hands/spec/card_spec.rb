require_relative '../lib/card'

module PokerHandsKata
  describe "Card" do
    describe "from_string" do
      it "should return instances of Card classes with correct suit and values" do
        club_2 = Card.from_string("2C")
        club_2.suit.should == Card::CLUB
        club_2.value.should == "2"
        club_2.score_value.should == 2

        diamond_10 = Card.from_string("TD")
        diamond_10.suit.should == Card::DIAMOND
        diamond_10.value.should == "T"
        diamond_10.score_value.should == 10

        heart_jack = Card.from_string("JH")
        heart_jack.suit.should == Card::HEART
        heart_jack.value.should == "J"
        heart_jack.score_value.should == 11

        spade_queen = Card.from_string("QS")
        spade_queen.suit.should == Card::SPADE
        spade_queen.value.should == "Q"
        spade_queen.score_value.should == 12

        diamond_king = Card.from_string("KD")
        diamond_king.suit.should == Card::DIAMOND
        diamond_king.value.should == "K"
        diamond_king.score_value.should == 13

        spade_ace = Card.from_string("AS")
        spade_ace.suit.should == Card::SPADE
        spade_ace.value.should == "A"
        spade_ace.score_value.should == 14
      end
    end

    describe "comparison" do
      it "should compare with score_values" do
        club_2 = Card.from_string("2C")
        heart_jack = Card.from_string("JH")
        diamond_jack = Card.from_string("JD")
        spade_ace = Card.from_string("AS")

        club_2.should < heart_jack
        heart_jack.should == diamond_jack
        spade_ace.should > heart_jack
      end
    end
  end
end
