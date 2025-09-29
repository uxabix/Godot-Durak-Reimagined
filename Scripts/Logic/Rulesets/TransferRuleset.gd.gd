# TransferRuleset.gd
class_name TransferRuleset
extends RulesetBase

func _init():
	name = "Translated 36 cards"
	cards_in_hand = 6
	translated_mode = true
	use_jokers = false
	suits = Card.ALL_SUITS
	ranks = Card.ALL_RANKS.slice(4)
