class_name RulesetBase
extends Resource

##
# Base class defining the core rules for different game modes.
# Provides methods for attack, defense, and transfer conditions.
##
const cd = preload("res://Scripts/Defines/card_defines.gd")

@export var name: String = "Classic 36 cards"   ## Name of the rule set
@export var cards_in_hand: int = 6              ## Number of cards each player starts with
@export var translated_mode: bool = false       ## Whether the mode supports card transfers
@export var use_jokers: bool = false            ## Whether jokers are included
@export var suits: Array[cd.Suit] = cd.ALL_SUITS
@export var ranks: Array[cd.Rank] = cd.ALL_RANKS.slice(4)


##
# Determines if a card can be transferred (used in translation mode).
# @param card - the card being considered for transfer
# @param attack_cards - the list of cards already in attack
##
func can_transfer(card: CardData, attack_cards: Array[CardData]) -> bool:
	var rank: cd.Rank = attack_cards[0].rank
	var flag: bool = true
	for i in attack_cards:
		if i.rank != rank:
			flag = false
			break
	flag = flag and card.rank == rank
	
	return translated_mode and flag


##
# Determines if a card can be played as an attack in the current context.
# By default, all cards can attack.
##
func can_attack(card: CardData) -> bool:
	return true
