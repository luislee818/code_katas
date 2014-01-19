require_relative '../lib/hand'

module PokerHandsKata
  describe "Hand" do
    describe "when initialized with a stirng of card values" do
      it "should have the correct cards" do
        hand = Hand.new("2H 3D 5S 9C KD")
        hand.cards.size.should == 5

        hand.cards[0].suit.should == Card::HEART
        hand.cards[0].value.should == "2"
        hand.cards[1].suit.should == Card::DIAMOND
        hand.cards[1].value.should == "3"
        hand.cards[2].suit.should == Card::SPADE
        hand.cards[2].value.should == "5"
        hand.cards[3].suit.should == Card::CLUB
        hand.cards[3].value.should == "9"
        hand.cards[4].suit.should == Card::DIAMOND
        hand.cards[4].value.should == "K"
      end
    end
  end
end
