class_name RulesetBase
extends Resource

const cd = preload("res://Scripts/Defines/card_defines.gd")

@export var name: String = "Classic 36 cards"
@export var cards_in_hand: int = 6
@export var translated_mode: bool = false
@export var use_jokers: bool = false
@export var suits: Array[cd.Suit] = cd.ALL_SUITS
@export var ranks: Array[cd.Rank] = cd.ALL_RANKS.slice(4)

# Determines if a card can be transferred (used in translation mode)
func can_transfer(card: CardData, attack_cards: Array[CardData]) -> bool:
	var rank: cd.Rank = attack_cards[0].rank
	var flag: bool = true
	for i in attack_cards:
		if i.rank != rank:
			flag = false
			break
	flag = flag and card.rank == rank
	
	return translated_mode and flag


# Determines if a card can be played in the current context
func can_attack(card: CardData) -> bool:
	return true
