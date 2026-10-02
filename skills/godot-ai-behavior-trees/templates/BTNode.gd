# res://src/core/components/behavior_tree/bt_node.gd
class_name BTNode
extends Node
## Base Behavior Tree Node Contract for Godot 4.x

enum Status { SUCCESS, FAILURE, RUNNING }

var blackboard: Blackboard = null
var actor: Node = null

func initialize(p_actor: Node, p_blackboard: Blackboard) -> void:
	actor = p_actor
	blackboard = p_blackboard
	for child: Node in get_children():
		if child is BTNode:
			(child as BTNode).initialize(p_actor, p_blackboard)

func tick(_delta: float) -> Status:
	return Status.SUCCESS
