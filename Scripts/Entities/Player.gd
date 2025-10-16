extends Node
class_name Player

##
# Represents a player entity in the game.
# Holds player-related data such as hand, state, and strategy.
##
var player_name: String                 ## Player display name
var type                                ## Type of player (human, AI, etc.)
var state                               ## Current game state (active, waiting, etc.)
var strategy                            ## Strategy logic (for AI-controlled players)
var hand: Array[CardData]               ## Cards currently held by the player
