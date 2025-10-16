@tool
extends Node2D
class_name EnemyHandContainer

# ------------------------------------------------------------------------------
# EnemyHandContainer
# Evenly distributes child "hand" nodes (Node2D) horizontally within the parent Control's width.
# Each hand node typically contains multiple card nodes.
# This container assumes sufficient horizontal space to fit all hands with uniform spacing.
# ------------------------------------------------------------------------------

# Layout configuration parameters
@export var animate: bool = true        # Enables smooth transition when hands move
@export var animation_time: float = 0.2 # Duration of hand movement animation (in seconds)
@export var min_margin: float = 30      # Minimum horizontal spacing between hands

# ------------------------------------------------------------------------------
# Lifecycle
# ------------------------------------------------------------------------------
func _ready() -> void:
	if Engine.is_editor_hint():
		_update_layout_deferred()

	if get_viewport():
		get_viewport().size_changed.connect(update_layout)

	child_entered_tree.connect(_on_child_changed)
	child_exiting_tree.connect(_on_child_changed)

	call_deferred("_update_layout_deferred")


# ------------------------------------------------------------------------------
# Internal callbacks
# ------------------------------------------------------------------------------
func _on_child_changed(_n: Node) -> void:
	call_deferred("_update_layout_deferred")

func _update_layout_deferred() -> void:
	update_layout()


# ------------------------------------------------------------------------------
# Utility: Convert local to global coordinates with rotation
# ------------------------------------------------------------------------------
func local_to_global(center: Vector2, local_point: Vector2, rotation: float) -> Vector2:
	return center + local_point.rotated(rotation)


# ------------------------------------------------------------------------------
# Utility: Get a specific rectangle corner in local space (origin = center)
# ------------------------------------------------------------------------------
func corner_local(size: Vector2, corner: String) -> Vector2:
	var hx = size.x * 0.5
	var hy = size.y * 0.5
	match corner:
		"top_left": return Vector2(-hx, -hy)
		"top_right": return Vector2(hx, -hy)
		"bottom_left": return Vector2(-hx, hy)
		"bottom_right": return Vector2(hx, hy)
		_: push_error("Unknown corner: %s" % corner); return Vector2.ZERO


# ------------------------------------------------------------------------------
# Utility: Get world-space position of a specific rectangle corner
# ------------------------------------------------------------------------------
func get_corner_world_position(center: Vector2, size: Vector2, rotation: float, corner: String = "bottom_left") -> Vector2:
	var local = corner_local(size, corner)
	return local_to_global(center, local, rotation)


# ------------------------------------------------------------------------------
# Calculates the total horizontal size of a given hand (Node2D).
# The size is derived from the positions of its first and last card nodes.
# ------------------------------------------------------------------------------
func get_hand_size(node: Node2D) -> float:
	var count = node.get_child_count()
	if count == 0:
		return 0.0
	if count < 2:
		return node.get_child(0).get_size().x
	
	var left_coord = get_corner_world_position(node.get_child(0).global_position, node.get_child(0).get_size(), rotation)
	var right_coord = get_corner_world_position(node.get_child(-1).global_position, node.get_child(0).get_size(), rotation, "bottom_right")
	return (right_coord - left_coord).length()
	
# ------------------------------------------------------------------------------
# Core layout routine.
# Evenly distributes all hand nodes across the available container width.
# Automatically scales hands down if their total required width exceeds container width.
# ------------------------------------------------------------------------------
func update_layout() -> void:
	var count := get_child_count()
	if count == 0:
		return

	var parent_control := get_parent() as Control
	if parent_control == null:
		push_warning("EnemyHandContainer: Parent is not a Control, layout skipped.")
		return

	var container_width := parent_control.size.x
	var hands: Array[HandContainer] = []

	var max_size := 0.0
	for child in get_children():
		if child is Node2D:
			hands.append(child)
			max_size = max(max_size, get_hand_size(child))

	if hands.is_empty():
		return

	var spacing := container_width / (count + 1)
	var required_width := (hands.size() * max_size + (hands.size() + 1) * min_margin) / scale.x
	if required_width > container_width:
		for hand in hands:
			hand.scale.x = container_width / required_width
			hand.scale.y = container_width / required_width
	else:
		for hand in hands:
			hand.scale.x = 1
			hand.scale.y = 1

	# Position each hand evenly across the container width.
	# Optionally animate movement if 'animate' is enabled.
	for i in range(count):
		var child := hands[i]
		var target_x := spacing * (i + 1) / scale.x
		if animate:
			child.create_tween().tween_property(child, "position:x", target_x, animation_time)
		else:
			child.position.x = target_x
