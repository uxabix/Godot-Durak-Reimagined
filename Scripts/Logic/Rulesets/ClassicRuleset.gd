class_name ClassicRuleset
extends RulesetBase

##
# Classic ruleset — no card translation.
# Uses a standard 36-card deck without jokers.
##
func _init():
	name = "Classic 36 cards"
	cards_in_hand = 6
	translated_mode = false
	use_jokers = false
	suits = cd.ALL_SUITS
	ranks = cd.ALL_RANKS.slice(4)


##
# In classic rules, transferring cards is not allowed.
##
func can_transfer(card, attack_card) -> bool:
	return false
