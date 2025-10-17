extends Node2D
class_name GameTable

# ------------------------------------------------------------------------------
# GameTable
# Handles the visual representation of the main card table, including:
# - Displaying the deck and trump card.
# - Managing previews and updating the deck layout.
# - Initializing the game state and player UI references.
# ------------------------------------------------------------------------------

const game_defines = preload("res://Scripts/Defines/game_defines.gd")

@export var deck: Node;

# ------------------------------------------------------------------------------
# Lifecycle
# ------------------------------------------------------------------------------

# Called once when the node enters the scene tree
func _ready() -> void:
	UiManager.remove_preview_nodes(self)
	GameManager.start_game()
	deck.update_deck(GameManager.deck)
	UiManager.player_hand = $CanvasLayer/PlayerHand/HandContainer
	$CanvasLayer/PlayerHand/HandContainer.set_cards(GameManager.current_player.hand, game_defines.player_appearance)


# Called every frame (currently unused)
func _process(_delta: float) -> void:
	pass
