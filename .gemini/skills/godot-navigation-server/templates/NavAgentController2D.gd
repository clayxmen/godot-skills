# res://src/core/components/ai/nav_agent_controller_2d.gd
class_name NavAgentController2D
extends Node
## 2D NavigationAgent Controller with RVO2 Dynamic Obstacle Avoidance for Godot 4.x

signal destination_reached()

@export var agent: NavigationAgent2D
@export var character: CharacterBody2D
@export var movement_speed: float = 160.0
@export var acceleration: float = 1200.0

var _is_active: bool = false

func _ready() -> void:
	if agent:
		agent.velocity_computed.connect(_on_velocity_computed)
		agent.navigation_finished.connect(_on_navigation_finished)

func set_target(destination: Vector2) -> void:
	if not agent or not character:
		return
	agent.target_position = destination
	_is_active = true

func _physics_process(delta: float) -> void:
	if not _is_active or not agent or not character:
		return

	if agent.is_navigation_finished():
		_is_active = false
		character.velocity = character.velocity.move_toward(Vector2.ZERO, acceleration * delta)
		character.move_and_slide()
		return

	var next_path_pos: Vector2 = agent.get_next_path_position()
	var intended_direction: Vector2 = (next_path_pos - character.global_position).normalized()
	var intended_velocity: Vector2 = intended_direction * movement_speed

	if agent.avoidance_enabled:
		agent.set_velocity(intended_velocity)
	else:
		_on_velocity_computed(intended_velocity)

func _on_velocity_computed(safe_velocity: Vector2) -> void:
	if character:
		character.velocity = safe_velocity
		character.move_and_slide()

func _on_navigation_finished() -> void:
	_is_active = false
	destination_reached.emit()
