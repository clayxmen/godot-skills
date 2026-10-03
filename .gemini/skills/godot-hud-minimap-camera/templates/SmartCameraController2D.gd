# res://src/core/services/camera/smart_camera_controller_2d.gd
class_name SmartCameraController2D
extends Camera2D
## Multi-Target Bounding Box Dynamic Framing Camera for Godot 4.x

@export var targets: Array[Node2D] = []
@export var smooth_speed: float = 6.0
@export var min_zoom: float = 0.6
@export var max_zoom: float = 1.4
@export var margin_padding: Vector2 = Vector2(160.0, 120.0)

func _process(delta: float) -> void:
	var valid_targets: Array[Node2D] = targets.filter(func(t: Node2D) -> bool: return is_instance_valid(t))
	if valid_targets.is_empty():
		return

	var bounds: Rect2 = Rect2(valid_targets[0].global_position, Vector2.ZERO)
	for t: Node2D in valid_targets:
		bounds = bounds.expand(t.global_position)

	var target_center: Vector2 = bounds.get_center()
	global_position = global_position.lerp(target_center, smooth_speed * delta)

	var viewport_size: Vector2 = get_viewport_rect().size
	var desired_size: Vector2 = bounds.size + margin_padding * 2.0
	var zoom_x: float = viewport_size.x / maxf(desired_size.x, 1.0)
	var zoom_y: float = viewport_size.y / maxf(desired_size.y, 1.0)
	var target_zoom: float = clampf(minf(zoom_x, zoom_y), min_zoom, max_zoom)

	zoom = zoom.lerp(Vector2(target_zoom, target_zoom), smooth_speed * delta)
