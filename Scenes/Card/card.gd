@tool
extends Node2D

# Preload the Card definitions containing enums and helper functions
const Card = preload("res://Scripts/Defines/card_defines.gd")

# Indicates whether the card is face-up (true) or face-down (false)
@export var is_face_up: bool = true:
	set(value):
		is_face_up = value
		flip()  # Update the card's visibility when this property changes

# Suit of the card (Hearts, Spades, etc.)
@export var suit: Card.Suit:
	set(value):
		suit = value
		set_textures()  # Update textures when suit changes

# Rank of the card (2, 3, ..., King, Ace)
@export var rank: Card.Rank:
	set(value):
		rank = value
		set_textures()  # Update textures according to the rank
		set_text()      # Updaste rank text if applicable

# Type of the card (for game logic)
@export var type: Card.Type

# Flip the card to show either front or back
func flip():
	$Front.visible = is_face_up
	$Back.visible = not is_face_up

# Set the textures for suit and rank images based on current card values
func set_textures():
	# Update suit images
	for i in $Front/Suits.get_children():
		i.texture = load("res://Assets/Textures/Cards/Suits/"
			+ Card.get_suit_name(suit) + "/Suit.png")
	
	# Determine whether rank has a dedicated texture
	$Front/Images/Rank.visible = rank in Card.HAS_TEXTURE
	$Front/Images/Suits.visible = not $Front/Images/Rank.visible
	
	if $Front/Images/Rank.visible:
		# Load the rank texture if it exists
		$Front/Images/Rank.texture = load("res://Assets/Textures/Cards/Suits/"
			+ Card.get_suit_name(suit) + "/Ranks/"
			+ Card.get_rank_name(rank) + ".png")
	else:
		# Otherwise, use pattern overlay for the rank
		var i = 0
		for image in $Front/Images/Suits.get_children():
			image.visible = Card.patterns[rank][i]
			image.texture = load("res://Assets/Textures/Cards/Suits/"
				+ Card.get_suit_name(suit) + "/Suit.png")
			i += 1


# Set textual representation of the card rank (for UI labels)
func set_text():
	for i in $Front/Ranks/Control.get_children():
		var name: String = Card.get_rank_name(rank)
		# If rank name is empty, fallback to numerical value
		name = str(rank + Card.FIRST_CARD_VALUE) if name == "" else name
		# Display abbreviated name if too long
		i.text = name if len(name) < 3 else name[0]

# Called when the node enters the scene tree
func _ready() -> void:
	set_textures()
	set_text()

# Process function called every frame (currently unused)
func _process(delta: float) -> void:
	pass
