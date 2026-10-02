# res://src/core/components/goap/goap_goal.gd
class_name GOAPGoal
extends Resource
## Goal Definition for GOAP AI in Godot 4.x

@export var goal_name: StringName = &""
@export var priority: float = 10.0
@export var desired_state: Dictionary = {}

func calculate_priority(_actor: Node, _world_state: Dictionary) -> float:
	return priority
