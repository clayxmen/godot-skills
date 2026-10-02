# res://src/core/components/ai/nav_agent_controller_3d.gd
class_name NavAgentController3D
extends Node
## 3D NavigationAgent Controller with Smooth Turning & RVO2 Dynamic Avoidance for Godot 4.x

signal destination_reached()

@export var agent: NavigationAgent3D
@export var character: CharacterBody3D
@export var movement_speed: float = 5.0
@export var rotation_speed: float = 8.0

var _is_active: bool = false

func _ready() -> void:
	if agent:
		agent.velocity_computed.connect(_on_velocity_computed)
		agent.navigation_finished.connect(_on_navigation_finished)

func set_target(destination: Vector3) -> void:
	if not agent or not character:
		return
	agent.target_position = destination
	_is_active = true

func _physics_process(delta: float) -> void:
	if not _is_active or not agent or not character:
		return

	if agent.is_navigation_finished():
		_is_active = false
		return

	var next_path_pos: Vector3 = agent.get_next_path_position()
	var move_dir: Vector3 = (next_path_pos - character.global_position).normalized()
	move_dir.y = 0.0

	if move_dir.length_squared() > 0.001:
		var target_rot: float = atan2(move_dir.x, move_dir.z)
		character.rotation.y = rotate_toward(character.rotation.y, target_rot, rotation_speed * delta)

	var intended_velocity: Vector3 = move_dir * movement_speed

	if agent.avoidance_enabled:
		agent.set_velocity(intended_velocity)
	else:
		_on_velocity_computed(intended_velocity)

func _on_velocity_computed(safe_velocity: Vector3) -> void:
	if character:
		character.velocity.x = safe_velocity.x
		character.velocity.z = safe_velocity.z
		character.move_and_slide()

func _on_navigation_finished() -> void:
	_is_active = false
	destination_reached.emit()
