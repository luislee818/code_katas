module PokerHandsKata
  class Hand
    attr_reader :cards

    def initialize(str)
      card_str_values = str.split
      @cards = []

      card_str_values.each do |str_value|
        @cards << Card.from_string(str_value)
      end
    end
  end

  describe "Hand" do
    describe "when initialized with a stirng of card values" do
      it "should have the correct cards" do
        hand = Hand.new("2H 3D 5S 9C KD")
        hand.cards.should include(Card.from_string("2H"))
        hand.cards.should include(Card.from_string("3D"))
        hand.cards.should include(Card.from_string("5S"))
        hand.cards.should include(Card.from_string("9C"))
        hand.cards.should include(Card.from_string("KD"))

        hand.cards.should_not include(Card.from_string("QC"))
      end
    end
  end

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

    def ==(other)
      (self.suit == other.suit) and (self.value == other.value)
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

    describe "equality test with ==" do
      it "should return false when two cards have different suits" do
        card_1 = Card.from_string("2S")
        card_2 = Card.from_string("2C")
        card_1.should_not == card_2
      end

      it "should return false when two cards have different values" do
        card_1 = Card.from_string("2C")
        card_2 = Card.from_string("TC")
        card_1.should_not == card_2
      end

      it "should return true when two cards have the same suit and value" do
        card_1 = Card.from_string("2C")
        card_2 = Card.from_string("2C")
        card_1.should == card_2
      end
    end
  end
end
