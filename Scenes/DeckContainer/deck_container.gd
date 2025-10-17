extends Control


# Reference to the scene representing a single card (used to instantiate deck cards)
@export var card_scene: PackedScene


# ------------------------------------------------------------------------------
# Deck Management
# ------------------------------------------------------------------------------

# Removes all existing cards and trump visuals from the deck container
func clear_deck() -> void:
	for child in $TrumpContainer.get_children():
		child.queue_free()
	for child in $CardsContainer.get_children():
		child.queue_free()

# Updates the deck display based on the provided Deck object
func update_deck(deck: Deck) -> void:
	clear_deck()
	# Update deck card count label
	$CardsCount.text = str(deck.size())

	# Create and display the trump card (top of the deck)
	var trump := card_scene.instantiate()
	trump.init(deck.get_first())
	$TrumpContainer.add_child(trump)

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
		$CardsContainer.add_child(card)
		card.rotation = angle
		card.position = Vector2(pos, pos)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
