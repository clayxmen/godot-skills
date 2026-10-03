# res://src/tools/custom_grid_gizmo.gd
@tool
class_name CustomGridGizmo
extends Node2D
## Crash-Proof In-Editor Tool Gizmo for Godot 4.x
## Demonstrates safe @tool lifecycle, property change notifications, and draw calls.

@export_group("Grid Setup")
@export var cell_size: Vector2 = Vector2(32, 32):
	set(value):
		cell_size = value.clamp(Vector2(4, 4), Vector2(512, 512))
		if is_inside_tree():
			queue_redraw()

@export var grid_dimensions: Vector2i = Vector2i(8, 8):
	set(value):
		grid_dimensions = value.clamp(Vector2i(1, 1), Vector2i(128, 128))
		if is_inside_tree():
			queue_redraw()

@export var line_color: Color = Color(0.2, 0.8, 1.0, 0.35):
	set(value):
		line_color = value
		if is_inside_tree():
			queue_redraw()

func _draw() -> void:
	if not Engine.is_editor_hint():
		return # Do not render editor gizmo during active gameplay

	# Horizontal grid lines
	for y: int in range(grid_dimensions.y + 1):
		var start: Vector2 = Vector2(0, y * cell_size.y)
		var end: Vector2 = Vector2(grid_dimensions.x * cell_size.x, y * cell_size.y)
		draw_line(start, end, line_color, 1.0)

	# Vertical grid lines
	for x: int in range(grid_dimensions.x + 1):
		var start: Vector2 = Vector2(x * cell_size.x, 0)
		var end: Vector2 = Vector2(x * cell_size.x, grid_dimensions.y * cell_size.y)
		draw_line(start, end, line_color, 1.0)
