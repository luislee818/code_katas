module PokerHandsKata
  class Card
    attr_reader :suit, :value

    CLUB = :CLUB
    SPADE = :SPADE
    DIAMOND = :DIAMOND
    HEART = :HEART
    SUITS = {
      "C" => CLUB,
      "S" => SPADE,
      "D" => DIAMOND,
      "H" => HEART
    }

    def self.from_string(str)
      value_char = str[0]
      suit_char = str[1]

      self.new(value_char, SUITS[suit_char])
    end

    private
    def initialize(value, suit)
      @value = value
      @suit = suit
    end
  end

  describe "Card" do
    describe "from_string" do
      it "should return instances of Card classes with correct suit and values" do
        club_2 = Card.from_string("2C")
        club_2.suit.should == Card::CLUB
        club_2.value.should == "2"

        diamond_10 = Card.from_string("TD")
        diamond_10.suit.should == Card::DIAMOND
        diamond_10.value.should == "T"

        heart_jack = Card.from_string("JH")
        heart_jack.suit.should == Card::HEART
        heart_jack.value.should == "J"

        spade_queen = Card.from_string("QS")
        spade_queen.suit.should == Card::SPADE
        spade_queen.value.should == "Q"
      end
    end
  end
end
