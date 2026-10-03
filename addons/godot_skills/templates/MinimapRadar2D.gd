# res://src/ui/hud/minimap_radar_2d.gd
class_name MinimapRadar2D
extends Control
## 2D Circular Radar Minimap with Dynamic Blip Tracking for Godot 4.x

@export var player: Node2D
@export var radar_radius: float = 80.0
@export var zoom_factor: float = 0.15
@export var enemy_group: StringName = &"enemy"

func _draw() -> void:
	if not player or not is_instance_valid(player):
		return

	var center: Vector2 = size * 0.5

	draw_circle(center, radar_radius, Color(0.05, 0.05, 0.08, 0.8))
	draw_arc(center, radar_radius, 0, TAU, 32, Color(0.2, 0.8, 1.0, 0.5), 2.0)
	draw_circle(center, 4.0, Color(0.2, 1.0, 0.3))

	var enemies: Array[Node] = get_tree().get_nodes_in_group(enemy_group)
	for node: Node in enemies:
		if not (node is Node2D):
			continue
		var enemy: Node2D = node as Node2D
		var offset: Vector2 = (enemy.global_position - player.global_position) * zoom_factor

		if offset.length() <= radar_radius - 4.0:
			draw_circle(center + offset, 3.0, Color(1.0, 0.2, 0.2))
		else:
			var edge_pos: Vector2 = center + offset.normalized() * (radar_radius - 4.0)
			draw_circle(edge_pos, 2.0, Color(1.0, 0.2, 0.2, 0.6))

func _process(_delta: float) -> void:
	queue_redraw()
