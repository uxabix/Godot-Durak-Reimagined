extends Node

##
# Central game manager responsible for controlling
# the main game state, players, rules, and deck operations.
##
const cd = preload("res://Scripts/Defines/card_defines.gd")

var trump: cd.Suit = cd.Suit.DIAMONDS          ## Current trump suit for the game
var ruleset: RulesetBase = preload("res://Scripts/Logic/Rulesets/ClassicRuleset.gd").new()  ## Active game ruleset
var deck: Deck = Deck.new()                    ## Main deck used in the current game
var discard_pile: DiscardPile                  ## Pile for discarded cards
var players: Array[Player] = []                ## List of all players (human and bots)
var current_player: Player

##
# Creates and initializes players.
# @param player_count - number of human players
# @param bot_count - number of AI players
##
func set_players(player_count: int, bot_count: int = 0) -> void:
	for i in range(player_count + bot_count):
		var player: Player = Player.new()
		player.type = "Player" if i < player_count else "Bot"
		players.append(player)

##
# Update trump suit for each player
##
func notify_players_trump():
	for player in players:
		player.trump = trump

##
# Starts a new game session.
# Initializes players, deck, ruleset, and deals cards.
##
func start_game() -> void:
	set_players(1, 2)
	current_player = players[0]
	self.ruleset = ruleset
	deck = Deck.new()
	deck.init(ruleset)
	trump = deck.get_first().suit
	notify_players_trump()
	discard_pile = DiscardPile.new()

	# Deal cards to each player
	for player in players:
		for i in range(ruleset.cards_in_hand):
			player.add_card(deck.draw_card())


##
# Handles logic for when a player plays a card.
# Validates the move according to the ruleset.
# @param player - the player playing the card
# @param card - the card being played
##
func play_card(player: Player, card: CardData) -> void:
	if ruleset.can_attack(card):
		discard_pile.add_card(card)
		player.hand.erase(card)
