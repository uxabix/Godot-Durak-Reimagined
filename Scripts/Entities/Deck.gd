extends Node
class_name Deck

var cards: Array[CardData] = []

# Initializes the deck based on a ruleset
func init(ruleset):
	cards.clear()
	for suit in ruleset.suits:
		for rank in ruleset.ranks:
			var card = CardData.new()
			card.suit = suit
			card.rank = rank
			cards.append(card)
	cards.shuffle()

# Draws the top card from the deck
func draw_card() -> CardData:
	return null if cards.is_empty() else cards.pop_back() 

func get_first() -> CardData:
	return null if cards.is_empty() else cards[0]

# Shuffles the deck
func shuffle() -> void:
	cards.shuffle()

# Returns the number of remaining cards
func size() -> int:
	return cards.size()
