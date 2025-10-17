class_name CardAppearanceData
extends Resource


@export var is_current_player: bool = false
@export var cards_hidden: bool = false


func _init(current_player: bool, hidden: bool) -> void:
	self.is_current_player = current_player
	self.cards_hidden = hidden
