extends Node2D
class_name GameTable

# ------------------------------------------------------------------------------
# GameTable
# Handles the visual representation of the main card table, including:
# - Displaying the deck and trump card.
# - Managing previews and updating the deck layout.
# - Initializing the game state and player UI references.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Exported Properties
# ------------------------------------------------------------------------------

# Reference to the scene representing a single card (used to instantiate deck cards)
@export var card_scene: PackedScene


# ------------------------------------------------------------------------------
# Deck Management
# ------------------------------------------------------------------------------

# Removes all existing cards and trump visuals from the deck container
func clear_deck() -> void:
	for child in $CanvasLayer/DeckContainer/TrumpContainer.get_children():
		child.queue_free()
	for child in $CanvasLayer/DeckContainer/CardsContainer.get_children():
		child.queue_free()


# Updates the deck display based on the provided Deck object
func update_deck(deck: Deck) -> void:
	clear_deck()
	# Update deck card count label
	$CanvasLayer/DeckContainer/CardsCount.text = str(deck.size())

	# Create and display the trump card (top of the deck)
	var trump := card_scene.instantiate()
	trump.init(deck.get_first())
	$CanvasLayer/DeckContainer/TrumpContainer.add_child(trump)

	# Visually stack the remaining cards with slight offset and rotation
	var angle := 0.0
	var pos := 0.0
	var counter := 0
	for i in deck.cards.slice(1):
		counter += 1
		if counter % 4:
			continue  # Skip some cards to avoid overcrowding visually
		pos += 2
		angle += deg_to_rad(2)
		var card := card_scene.instantiate()
		card.is_face_up = false
		$CanvasLayer/DeckContainer/CardsContainer.add_child(card)
		card.rotation = angle
		card.position = Vector2(pos, pos)


# Hides the card preview elements in the deck containers
func disable_previews() -> void:
	$CanvasLayer/DeckContainer/TrumpContainer/PreviewTrump.visible = false
	$CanvasLayer/DeckContainer/CardsContainer/PreviewCard.visible = false


# ------------------------------------------------------------------------------
# Lifecycle
# ------------------------------------------------------------------------------

# Called once when the node enters the scene tree
func _ready() -> void:
	disable_previews()
	GameManager.start_game()
	update_deck(GameManager.deck)
	UiManager.player_hand = $CanvasLayer/PlayerHand/HandContainer


# Called every frame (currently unused)
func _process(_delta: float) -> void:
	pass
