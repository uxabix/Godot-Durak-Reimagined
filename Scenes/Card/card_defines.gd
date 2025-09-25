extends Node

enum Type {
	NORMAL,
	TRUMP,
	SPECIAL
}

enum Suit {
	HEARTS,
	DIAMONDS,
	CLUBS,
	SPADES
}

const FIRST_CARD_VALUE = 2

enum Rank {
	TWO,
	THREE,
	FOUR,
	FIVE,
	SIX,
	SEVEN,
	EIGHT,
	NINE,
	TEN,
	JACK,
	QUEEN,
	KING,
	ACE
}

const NUMBERS = 9

static var patterns = [
	[0, 0, 0,
	 1, 0, 1,
	 0, 0, 0,
		0],
	[0, 0, 0,
	 1, 1, 1,
	 0, 0, 0,
		0],
	[0, 0, 0,
	 1, 1, 1,
	 0, 1, 0,
		0],
	[0, 1, 0,
	 1, 1, 1,
	 0, 1, 0,
		0],
	[1, 0, 1,
	 0, 1, 0,
	 1, 1, 1,
		0],
	[1, 0, 1,
	 1, 1, 1,
	 1, 0, 1,
		0],
	[1, 1, 1,
	 1, 0, 1,
	 1, 0, 1,
		1],
	[1, 1, 1,
	 1, 0, 1,
	 1, 1, 1,
		1],
	[1, 1, 1,
	 1, 1, 1,
	 1, 1, 1,
		1],
	[1, 1, 1,
	 1, 1, 1,
	 1, 1, 1,
		1],
	[1, 1, 1,
	 1, 1, 1,
	 1, 1, 1,
		1],
	[1, 1, 1,
	 1, 1, 1,
	 1, 1, 1,
		1],
	[0, 0, 0,
	 0, 1, 0,
	 0, 0, 0,
		0],
]

const ALL_SUITS = [Suit.HEARTS, Suit.DIAMONDS, Suit.CLUBS, Suit.SPADES]
const ALL_RANKS = [Rank.TWO, Rank.THREE, Rank.FOUR, Rank.FIVE, Rank.SIX,
	 Rank.SEVEN, Rank.EIGHT, Rank.NINE, Rank.TEN,  Rank.JACK, Rank.QUEEN,
	 Rank.KING, Rank.ACE]
	

static func get_suit_name(suit: Suit) -> String:
	match suit:
		Suit.HEARTS: return "Hearts"
		Suit.CLUBS: return "Clubs"
		Suit.SPADES: return "Spades"
		Suit.DIAMONDS: return "Diamonds"
		_: return ""
		
static func get_rank_name(rank: Rank) -> String:
	match rank:
		Rank.JACK: return "Jack"
		Rank.QUEEN: return "Queen"
		Rank.KING: return "King"
		Rank.ACE: return "Ace"
		_: return ""

const HAS_TEXTURE = [Rank.JACK, Rank.QUEEN, Rank.KING]
