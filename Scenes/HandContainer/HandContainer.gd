@tool
extends Node2D
class_name HandContainer

@export var spacing: float = 80.0:
	set(value):
		spacing = value
		update_layout()
@export var y_spacing: float = 40.0:
	set(value):
		y_spacing = value
		update_layout()
@export var vertical_offset: float = 0.0:
	set(value):
		vertical_offset = value
		update_layout()
@export var fan_angle: float = 18.0:
	set(value):
		fan_angle = value
		update_layout()
@export var animate: bool = true
@export var animation_time: float = 0.18:
	set(value):
		animation_time = value
		update_layout()
@export var is_face_up: bool = true:
	set(value):
		is_face_up = value
		flip_cards()  # Update the cards visibility when this property changes

func _ready() -> void:
	if Engine.is_editor_hint():
		update_layout()
	child_entered_tree.connect(_on_child_changed)
	child_exiting_tree.connect(_on_child_changed)
	call_deferred("_deferred_update_layout")

func _notification(what: int) -> void:
	if Engine.is_editor_hint():
		if what == NOTIFICATION_TRANSFORM_CHANGED or what == NOTIFICATION_PARENTED:
			update_layout()

func _on_child_changed(node: Node) -> void:
	call_deferred("_deferred_update_layout")

func _deferred_update_layout() -> void:
	update_layout()

func update_layout() -> void:
	var count := get_child_count()
	if count == 0:
		return

	var total_width := (count - 1) * spacing
	var start_x := -total_width * 0.5
	var center_y := vertical_offset
	var center_index := (count - 1) / 2.0

	var angle_step := 0.0
	if fan_angle != 0.0:
		angle_step = deg_to_rad(fan_angle) / max(count - 1, 1)

	for i in range(count):
		var node := get_child(i)
		if not node is Node2D:
			continue

		# X позиция — линейно
		var pos_x := start_x + i * spacing
		# смещение от -1 до 1 (левый край = -1, центр = 0, правый край = 1)
		var offset: float = (i - center_index) / center_index if center_index != 0 else 0.0
		# Y смещение
		var pos_y: float = center_y + y_spacing * -cos(offset * PI * 0.5)
		var target_pos := Vector2(pos_x, pos_y)

		var target_rot := 0.0
		if fan_angle != 0.0 and center_index != 0:
			target_rot = -deg_to_rad(fan_angle) * 0.5 + i * angle_step

		if animate:
			var t = create_tween()
			t.tween_property(node, "position", target_pos, animation_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
			t.tween_property(node, "rotation", target_rot, animation_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		else:
			node.position = target_pos
			node.rotation = target_rot


func flip_cards():
	for child in get_children():
		if child.has_method("flip"):
			child.is_face_up = is_face_up


func show_cards():
	pass
