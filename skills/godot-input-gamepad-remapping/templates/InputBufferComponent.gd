# res://src/core/components/input/input_buffer_component.gd
class_name InputBufferComponent
extends Node
## Action Press Input Buffer Component for Godot 4.x

@export var buffer_duration: float = 0.15

var _buffer: Dictionary[StringName, float] = {}

func _unhandled_input(event: InputEvent) -> void:
	for action: StringName in _buffer.keys():
		if event.is_action_pressed(action):
			_buffer[action] = Time.get_ticks_msec() / 1000.0

func register_action(action_name: StringName) -> void:
	_buffer[action_name] = -999.0

func consume_action(action_name: StringName) -> bool:
	if not _buffer.has(action_name):
		return false

	var press_time: float = _buffer[action_name]
	var current_time: float = Time.get_ticks_msec() / 1000.0

	if current_time - press_time <= buffer_duration:
		_buffer[action_name] = -999.0
		return true

	return false
