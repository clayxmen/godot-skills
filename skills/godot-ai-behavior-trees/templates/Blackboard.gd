# res://src/core/components/behavior_tree/blackboard.gd
class_name Blackboard
extends RefCounted
## Shared Context Memory Object for Behavior Trees in Godot 4.x

var _data: Dictionary[StringName, Variant] = {}

func set_value(key: StringName, value: Variant) -> void:
	_data[key] = value

func get_value(key: StringName, default_value: Variant = null) -> Variant:
	return _data.get(key, default_value)

func has_value(key: StringName) -> bool:
	return _data.has(key)

func erase_value(key: StringName) -> void:
	_data.erase(key)

func clear() -> void:
	_data.clear()
