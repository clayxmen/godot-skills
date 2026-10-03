# res://src/core/components/state_machine/state.gd
class_name State
extends Node
## Base State Contract for Godot 4.x State Machines
## Override enter, exit, update, and physics_update in your concrete states.

signal transitioned(next_state_name: StringName, payload: Dictionary)

var actor: Node = null
var state_machine: StateMachine = null

func initialize(p_actor: Node, p_machine: StateMachine) -> void:
	actor = p_actor
	state_machine = p_machine

func enter(_payload: Dictionary = {}) -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass

func handle_input(_event: InputEvent) -> void:
	pass
