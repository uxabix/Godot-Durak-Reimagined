extends Node

const cd = preload("res://Scripts/Defines/card_defines.gd")

var trump: cd.Suit = cd.Suit.DIAMONDS
var ruleset: RulesetBase = preload("res://Scripts/Logic/Rulesets/ClassicRuleset.gd").new()
var deck: Deck = Deck.new()
var discard_pile: DiscardPile
var players: Array[Player] = []


func set_players(player_count: int, bot_count: int = 0):
	for i in range(player_count + bot_count):
		var player: Player = Player.new()
		player.type = "Player" if i < player_count else "Bot"
		players.append(player)

func start_game():
	set_players(1, 2)
	self.ruleset = ruleset
	deck = Deck.new()
	deck.init(ruleset)
	trump = deck.get_first().suit
	discard_pile = DiscardPile.new()
	# Initialize players, deal cards, etc.
	for player in players:
		for i in range(ruleset.cards_in_hand):
			player.hand.append(deck.draw_card())
			
	for i in players:
		print(i.hand)

func play_card(player, card):
	# Handle game rules for playing a card
	if ruleset.can_attack(card):
		# Move card to table or discard
		discard_pile.add_card(card)
		player.hand.remove_card(card)
