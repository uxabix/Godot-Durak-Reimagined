@tool
extends Node2D
class_name Card

# Preload the Card definitions containing enums and helper functions
const cd = preload("res://Scripts/Defines/card_defines.gd")

# Indicates whether the card is face-up (true) or face-down (false)
@export var is_face_up: bool = true:
	set(value):
		is_face_up = value
		flip()  # Update the card's visibility when this property changes

# Suit of the card (Hearts, Spades, etc.)
@export var suit: cd.Suit:
	set(value):
		suit = value
		set_textures()  # Update textures when suit changes

# Rank of the card (2, 3, ..., King, Ace)
@export var rank: cd.Rank:
	set(value):
		rank = value
		set_textures()  # Update textures according to the rank
		set_text()      # Updaste rank text if applicable

@export var animate: bool = false
@export var collision: bool = true:
	set (value):
		collision = value
		$HoverArea/CollisionShape2D.disabled = not value

# Flip the card to show either front or back
func flip():
	$Front.visible = is_face_up
	$Back.visible = not is_face_up

# Set the textures for suit and rank images based on current card values
func set_textures():
	# Update suit images
	for i in $Front/Suits.get_children():
		i.texture = load("res://Assets/Textures/Cards/Suits/"
			+ cd.get_suit_name(suit) + "/Suit.png")
	
	# Determine whether rank has a dedicated texture
	$Front/Images/Rank.visible = rank in cd.HAS_TEXTURE
	$Front/Images/Suits.visible = not $Front/Images/Rank.visible
	
	if $Front/Images/Rank.visible:
		# Load the rank texture if it exists
		$Front/Images/Rank.texture = load("res://Assets/Textures/Cards/Suits/"
			+ cd.get_suit_name(suit) + "/Ranks/"
			+ cd.get_rank_name(rank) + ".png")
	else:
		# Otherwise, use pattern overlay for the rank
		var i = 0
		for image in $Front/Images/Suits.get_children():
			image.visible = cd.patterns[rank][i]
			image.texture = load("res://Assets/Textures/Cards/Suits/"
				+ cd.get_suit_name(suit) + "/Suit.png")
			i += 1


# Set textual representation of the card rank (for UI labels)
func set_text() -> void:
	for i in $Front/Ranks/Control.get_children():
		var card_name: String = cd.get_rank_name(rank)
		# If rank name is empty, fallback to numerical value
		card_name = str(rank + cd.FIRST_CARD_VALUE) if card_name == "" else card_name
		# Display abbreviated name if too long
		i.text = card_name if len(card_name) < 3 else card_name[0]


func init(data: CardData) -> void:
	suit = data.suit
	rank = data.rank



# Called when the node enters the scene tree
func _ready() -> void:
	set_textures()
	set_text()


# Process function called every frame (currently unused)
func _process(delta: float) -> void:
	pass


func _on_hover_area_mouse_entered() -> void:
	if not animate: return
	$AnimationPlayer.play("Hover")
	UiManager.card_hovered = get_index()


func _on_hover_area_mouse_exited() -> void:
	if not animate: return
	$AnimationPlayer.play_backwards("Hover")
	UiManager.card_hovered = null
