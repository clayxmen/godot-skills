# res://src/features/player/presentation/character_controller_3d.gd
class_name CharacterController3D
extends CharacterBody3D
## Kinematic 3D Character Controller for Godot 4.x
## Features mouse look, sprint/crouch states, slope snapping, and smooth acceleration.

@export_group("Movement Configuration")
@export var walk_speed: float = 5.0
@export var sprint_speed: float = 8.5
@export var crouch_speed: float = 2.8
@export var acceleration: float = 18.0
@export var deceleration: float = 22.0
@export var air_control: float = 4.0

@export_group("Jump & Gravity")
@export var jump_velocity: float = 4.8
@export var gravity_multiplier: float = 1.4

@export_group("Camera Integration")
@export var camera_rig: Node3D
@export var spring_arm: SpringArm3D
@export var mouse_sensitivity: float = 0.0025
@export var min_pitch_degrees: float = -80.0
@export var max_pitch_degrees: float = 75.0

var _gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity", 9.8) * 1.4
var _camera_rotation: Vector2 = Vector2.ZERO

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	floor_snap_length = 0.25
	floor_max_angle = deg_to_rad(45.0)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		var motion: Vector2 = (event as InputEventMouseMotion).relative
		_camera_rotation.x -= motion.x * mouse_sensitivity
		_camera_rotation.y = clampf(
			_camera_rotation.y - motion.y * mouse_sensitivity,
			deg_to_rad(min_pitch_degrees),
			deg_to_rad(max_pitch_degrees)
		)

		rotation.y = _camera_rotation.x
		if spring_arm:
			spring_arm.rotation.x = _camera_rotation.y
		elif camera_rig:
			camera_rig.rotation.x = _camera_rotation.y

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= _gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	var input_vec: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var move_dir: Vector3 = (transform.basis * Vector3(input_vec.x, 0.0, input_vec.y)).normalized()

	var target_speed: float = walk_speed
	if Input.is_action_pressed("sprint"):
		target_speed = sprint_speed
	elif Input.is_action_pressed("crouch"):
		target_speed = crouch_speed

	var current_accel: float = acceleration if is_on_floor() else air_control
	if move_dir.length() > 0.0:
		velocity.x = move_toward(velocity.x, move_dir.x * target_speed, current_accel * delta * target_speed)
		velocity.z = move_toward(velocity.z, move_dir.z * target_speed, current_accel * delta * target_speed)
	else:
		velocity.x = move_toward(velocity.x, 0.0, deceleration * delta * walk_speed)
		velocity.z = move_toward(velocity.z, 0.0, deceleration * delta * walk_speed)

	move_and_slide()
