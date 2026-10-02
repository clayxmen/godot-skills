# res://src/ui/core/ui_focus_navigator.gd
class_name UIFocusNavigator
extends Node
## Automatic Gamepad & Keyboard UI Focus Linker for Godot 4.x

@export var initial_focused_control: Control
@export var container_to_auto_wire: Control

func _ready() -> void:
	if container_to_auto_wire:
		_auto_wire_focus(container_to_auto_wire)

	if initial_focused_control and initial_focused_control.is_inside_tree():
		initial_focused_control.grab_focus()

func _auto_wire_focus(container: Control) -> void:
	var focusable_nodes: Array[Control] = []
	for child: Node in container.get_children():
		if child is Control and (child as Control).focus_mode != Control.FOCUS_NONE:
			focusable_nodes.append(child as Control)

	for i in range(focusable_nodes.size()):
		var curr: Control = focusable_nodes[i]
		var prev: Control = focusable_nodes[(i - 1 + focusable_nodes.size()) % focusable_nodes.size()]
		var next: Control = focusable_nodes[(i + 1) % focusable_nodes.size()]

		if container is VBoxContainer:
			curr.focus_neighbor_top = prev.get_path()
			curr.focus_neighbor_bottom = next.get_path()
		elif container is HBoxContainer:
			curr.focus_neighbor_left = prev.get_path()
			curr.focus_neighbor_right = next.get_path()
