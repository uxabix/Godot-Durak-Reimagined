extends Node2D


@export var card_scene: PackedScene

func clear_deck():
	for child in $CanvasLayer/DeckContainer/TrumpContainer.get_children():
		child.queue_free()
	for child in $CanvasLayer/DeckContainer/CardsContainer.get_children():
		child.queue_free()

func update_deck(deck: Deck):
	clear_deck()
	$CanvasLayer/DeckContainer/CardsCount.text = str(deck.size())
	var trump = card_scene.instantiate()
	trump.init(deck.get_first())
	$CanvasLayer/DeckContainer/TrumpContainer.add_child(trump)
	var angle = 0
	var pos = 0
	var counter = 0
	for i in deck.cards.slice(1):
		counter += 1
		if counter % 4:
			continue
		pos += 2
		angle += 3.14 / 180 * 2
		var card = card_scene.instantiate()
		card.is_face_up = false
		$CanvasLayer/DeckContainer/CardsContainer.add_child(card)
		card.rotation = angle
		card.position.x = pos
		card.position.y = pos

func disable_previews() -> void:
	$CanvasLayer/DeckContainer/TrumpContainer/PreviewTrump.visible = false
	$CanvasLayer/DeckContainer/CardsContainer/PreviewCard.visible = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	disable_previews()
	GameManager.start_game()
	update_deck(GameManager.deck)
	UiManager.player_hand = $CanvasLayer/PlayerHand/HandContainer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
