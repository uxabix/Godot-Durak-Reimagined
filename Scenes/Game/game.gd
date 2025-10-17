extends Node2D
class_name GameTable

# ------------------------------------------------------------------------------
# GameTable
# Handles the visual representation of the main card table, including:
# - Displaying the deck and trump card.
# - Managing previews and updating the deck layout.
# - Initializing the game state and player UI references.
# ------------------------------------------------------------------------------

@export var player_card_appearance: CardAppearanceData = preload("res://Scripts/Entities/Resources/CardAppearance/Variants/Player.tres")
@export var deck: Node;

# ------------------------------------------------------------------------------
# Lifecycle
# ------------------------------------------------------------------------------

func clear_players_containers():
	for child in $CanvasLayer/EnemyContainer/EnemyHandContainer.get_children():
		if "HandContainer" in child.name:
			child.queue_free()

func init_players():
	pass

# Called once when the node enters the scene tree
func _ready() -> void:
	UiManager.remove_preview_nodes(self)
	GameManager.start_game()
	deck.update_deck(GameManager.deck)
	UiManager.player_hand = $CanvasLayer/PlayerHand/HandContainer
	$CanvasLayer/PlayerHand/HandContainer.set_cards(GameManager.current_player.hand, player_card_appearance)


# Called every frame (currently unused)
func _process(_delta: float) -> void:
	pass
