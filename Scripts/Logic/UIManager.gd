extends Node


var card_hovered = null:
	set(value):
		card_hovered = value
		set_collisions()
		print(card_hovered)

var player_hand: HandContainer

func set_collisions():
	var i: int = 0
	for card: Card in player_hand.get_children():
		card.collision = card_hovered == i or card_hovered == null
		i += 1
