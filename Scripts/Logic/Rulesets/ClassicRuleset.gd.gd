class_name ClassicRuleset
extends RulesetBase

func _init():
	name = "Classic 36 cards"
	cards_in_hand = 6
	translated_mode = false
	use_jokers = false
	suits = Card.ALL_SUITS
	ranks = Card.ALL_RANKS.slice(4)

# Classic rules do not allow transfer
func can_transfer(card, attack_card) -> bool:
	return false
