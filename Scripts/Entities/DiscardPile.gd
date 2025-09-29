extends Node
class_name DiscardPile

var cards: Array[CardData] = []

func add_card(card: CardData):
	cards.append(card)

# Returns the number of remaining cards
func size() -> int:
	return cards.size()
