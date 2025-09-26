extends Node2D

# Preload the Card definitions containing enums and helper functions
const Card = preload("res://Scenes/Card/card_defines.gd")


@export var cards_count: bool
@export var is_translated_mode: bool
@export var rules: bool

var deck = []

func init_deck():
	for suit in Card.ALL_SUITS:
		for rank in Card.ALL_RANKS:
			deck.append(1)
	
func shuffle_deck():
	pass
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
