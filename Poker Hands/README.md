##Kata: Poker Hands
Compare two Poker Hands and decide which wins. A Poker hand comprises 5 cards dealt from a normal 52 card deck, and each card has a suit and a value. All suits have the same rank, for example the Ace of Clubs is not beaten by the Ace of Spades, they are equal.

A poker hand can be represented using symbols like this:

(Two of Hearts, 3 of Diamonds, 5 of Spades, 9 of Clubs, King

| Clubs | Diamonds | Hearts | Spades|
| ----- | -------- | ------ | ----- |
| C     | D        | H      | S     |



| 10  | Jack | Queen | King | Ace |
| --- | ---- | ----- | ---- | --- |
| T   | J    | Q     | K    | A   |

You compare Poker hands by deciding which has the higher rank, according to the categories below. These categories are listed in order of ascending rank. For example, a hand containing a Full House has higher rank than a hand containing a Pair.

* **High Card**: The value of the highest card in the hand. If the highest cards have the same value, the hands are ranked by the next highest, and so on.
* **Straight flush**: 5 cards of the same suit with consecutive values. Ranked by the highest card in the hand.

If you like, you can read the two hands to be compared from standard input, and write which won to standard output:

