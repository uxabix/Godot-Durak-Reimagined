class_name CardData
extends Resource

const Card = preload("res://Scripts/Defines/card_defines.gd")

@export var suit: Card.Suit
@export var rank: Card.Rank
@export var special: bool = false
