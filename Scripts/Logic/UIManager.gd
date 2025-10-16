extends Node

##
# Manages UI-related behaviors such as hover detection
# and collision activation for cards in the player's hand.
##
var card_hovered = null:
	set(value):
		card_hovered = value
		set_collisions()

var player_hand: HandContainer ## Reference to the player's HandContainer scene


##
# Updates which cards are interactive based on the hovered card.
# Only the hovered card (or all, if none is hovered) will have collision enabled.
##
func set_collisions() -> void:
	var i: int = 0
	for card: Card in player_hand.get_children():
		card.collision = card_hovered == i or card_hovered == null
		i += 1
