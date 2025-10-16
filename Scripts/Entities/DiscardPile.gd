extends Node
class_name DiscardPile

##
# Represents the discard pile (the stack of played cards).
# Stores all cards that have been discarded during the game.
##
var cards: Array[CardData] = []


##
# Adds a card to the discard pile.
##
func add_card(card: CardData) -> void:
	cards.append(card)


##
# Returns the number of cards in the discard pile.
##
func size() -> int:
	return cards.size()
