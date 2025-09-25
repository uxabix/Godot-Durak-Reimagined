extends Node2D
const Card = preload("res://Scenes/Card/card_defines.gd")

@export var suit: Card.Suit
@export var rank: Card.Rank
@export var type: Card.Type


func set_textures():
	for i in $Suits.get_children():
		i.texture = load("res://Scenes/Card/Textures/Suits/"
		 + Card.get_suit_name(suit) + "/Suit.png")
	$Images/Rank.visible = rank in Card.HAS_TEXTURE
	$Images/Suits.visible = not $Images/Rank.visible
	if $Images/Rank.visible:
		$Images/Rank.texture = load("res://Scenes/Card/Textures/Suits/" + Card.get_suit_name(suit) + 
		"/Ranks/" + Card.get_rank_name(rank) + ".png")
	else:
		var i = 0
		for image in $Images/Suits.get_children():
			image.visible = Card.patterns[rank][i]
			image.texture = load("res://Scenes/Card/Textures/Suits/"
			 + Card.get_suit_name(suit) + "/Suit.png")
			i += 1
			
			
func set_text():
	for i in $Ranks/Control.get_children():
		var name = Card.get_rank_name(rank)
		name = str(rank + Card.FIRST_CARD_VALUE) if name == "" else name
		i.text = name if len(name) < 3 else name[0] 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_textures()
	set_text()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
