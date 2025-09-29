extends Node

const Card = preload("res://Scripts/Defines/card_defines.gd")

var trump: Card.Suit = Card.Suit.DIAMONDS
var ruleset: RulesetBase = preload("res://Scripts/Logic/Rulesets/ClassicRuleset.gd.gd").new()
var deck: Deck = Deck.new()
var discard_pile: DiscardPile
var players: Array = []


func start_game():
	self.ruleset = ruleset
	deck = Deck.new()
	deck.init(ruleset)
	discard_pile = DiscardPile.new()
	# Initialize players, deal cards, etc.
	for player in players:
		for i in range(ruleset.cards_in_hand):
			player.hand.add_card(deck.draw_card())

func play_card(player, card):
	# Handle game rules for playing a card
	if ruleset.can_attack(card):
		# Move card to table or discard
		discard_pile.add_card(card)
		player.hand.remove_card(card)
