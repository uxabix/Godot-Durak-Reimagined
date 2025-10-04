class_name CardData
extends Resource

const cd = preload("res://Scripts/Defines/card_defines.gd")

@export var suit: cd.Suit
@export var rank: cd.Rank
@export var special: bool = false
