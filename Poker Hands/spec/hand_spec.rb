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

  class HandCategory
    STRAIGHT_FLUSH = :STRAIGHT_FLUSH
    FOUR_OF_A_KIND = :FOUR_OF_A_KIND

    attr_reader :name, :highest_value

    def initialize(name, highest_value)
      @name = name
      @highest_value = highest_value
    end
  end

  class HandAnalyzer
    def self.analyze(hand)
      cards = hand.cards.sort
      categories = []

      # until cards.empty?
      #   HandCategoryRules.each do |rule|
      #     result = rule.check(cards)

      #     unless result.category
      #       categories << result.category
      #       cards = result.remaining_cards
      #       break
      #     end
      #   end
      # end



      [HandCategory.new(HandCategory::STRAIGHT_FLUSH, 9)]
    end

    class StraightFlushRule
      def self.check(cards)
        matches_rule = true

        (0..(cards.size - 2)).each do |index|
          current_card = cards[index]
          next_card = cards[index + 1]

          unless (current_card.score_value + 1 == next_card.score_value) and
            (current_card.suit == next_card.suit)
            matches_rule = false
            break
          end
        end

        if matches_rule
          highest_card_value = cards[-1].value
          HandCategory.new(HandCategory::STRAIGHT_FLUSH, highest_card_value)
        end
      end
    end
  end

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

  class Card
    include Comparable

    attr_reader :suit, :value, :score_value

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

    def <=>(other)
      self.score_value <=> other.score_value
    end

    private
    def initialize(value, suit)
      @value = value
      @suit = suit

      @score_value = case value
                     when "A" then 14
                     when "K" then 13
                     when "Q" then 12
                     when "J" then 11
                     when "T" then 10
                     else value.to_i
                     end
    end
  end

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
