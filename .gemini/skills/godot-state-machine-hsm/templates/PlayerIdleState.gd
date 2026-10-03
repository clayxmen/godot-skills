# res://src/features/player/domain/states/player_idle_state.gd
class_name PlayerIdleState
extends State
## Concrete Player Idle State Example for Godot 4.x

func enter(_payload: Dictionary = {}) -> void:
	var character: CharacterBody2D = actor as CharacterBody2D
	if character:
		character.velocity.x = 0.0

func physics_update(_delta: float) -> void:
	var character: CharacterBody2D = actor as CharacterBody2D
	if not character:
		return

	if not character.is_on_floor():
		transitioned.emit(&"falling", {})
		return

	if Input.is_action_just_pressed("jump"):
		transitioned.emit(&"jumping", {})
		return

	var input_x: float = Input.get_axis("move_left", "move_right")
	if not is_zero_approx(input_x):
		transitioned.emit(&"running", {})
