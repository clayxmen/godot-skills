# res://src/core/components/goap/goap_action.gd
class_name GOAPAction
extends Resource
## Production GOAP Action Data Contract for Godot 4.x

@export var action_name: StringName = &""
@export var cost: float = 1.0
@export var preconditions: Dictionary = {}
@export var effects: Dictionary = {}

func is_valid(_actor: Node, _world_state: Dictionary) -> bool:
	return true

func execute(_actor: Node, _delta: float) -> bool:
	return true
