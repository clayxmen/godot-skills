# res://src/features/player/presentation/network_player_controller.gd
class_name NetworkPlayerController
extends CharacterBody2D
## Server-Authoritative Networked Player Controller for Godot 4.x
## Features Client-Side Prediction and Server State Reconciliation.

@export var move_speed: float = 200.0
@export var synchronizer: MultiplayerSynchronizer

var current_tick: int = 0
var position_history: Dictionary[int, Vector2] = {}

func _enter_tree() -> void:
	var peer_id: int = name.to_int()
	set_multiplayer_authority(peer_id)

func _physics_process(delta: float) -> void:
	if is_multiplayer_authority():
		current_tick += 1
		var input_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		
		# Local Prediction
		velocity = input_vector * move_speed
		move_and_slide()
		position_history[current_tick] = global_position

		if not multiplayer.is_server():
			_send_input_to_server.rpc_id(1, input_vector, current_tick)
	else:
		if not multiplayer.is_server():
			move_and_slide()

@rpc("any_peer", "call_remote", "unreliable_ordered")
func _send_input_to_server(input_vec: Vector2, client_tick: int) -> void:
	if not multiplayer.is_server():
		return

	velocity = input_vec.clamp(Vector2(-1, -1), Vector2(1, 1)) * move_speed
	move_and_slide()

	_receive_server_state.rpc_id(multiplayer.get_remote_sender_id(), global_position, client_tick)

@rpc("authority", "call_remote", "unreliable_ordered")
func _receive_server_state(server_position: Vector2, ack_tick: int) -> void:
	if not is_multiplayer_authority():
		return

	if position_history.has(ack_tick):
		var predicted_pos: Vector2 = position_history[ack_tick]
		var error_distance: float = predicted_pos.distance_to(server_position)

		if error_distance > 8.0:
			global_position = server_position

		for t: int in position_history.keys():
			if t <= ack_tick:
				position_history.erase(t)
