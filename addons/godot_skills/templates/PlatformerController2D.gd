# res://src/features/player/presentation/platformer_controller_2d.gd
class_name PlatformerController2D
extends CharacterBody2D
## Precision 2D Platformer Character Controller for Godot 4.x
## Includes Coyote Time, Jump Buffering, Variable Jump Height, and Wall Jumps.

@export_group("Horizontal Physics")
@export var max_speed: float = 240.0
@export var acceleration: float = 1200.0
@export var friction: float = 1400.0
@export var air_acceleration: float = 800.0
@export var air_friction: float = 400.0

@export_group("Vertical Jump Calculations")
@export var jump_height: float = 64.0:
	set(val):
		jump_height = val
		_recalculate_jump_physics()
@export var time_to_jump_peak: float = 0.35:
	set(val):
		time_to_jump_peak = val
		_recalculate_jump_physics()
@export var time_to_jump_descent: float = 0.28:
	set(val):
		time_to_jump_descent = val
		_recalculate_jump_physics()
@export var jump_cut_multiplier: float = 0.45

@export_group("Game Feel Timers")
@export var coyote_duration: float = 0.15
@export var jump_buffer_duration: float = 0.12

@export_group("Wall Interaction")
@export var wall_slide_max_speed: float = 120.0
@export var wall_jump_velocity: Vector2 = Vector2(220.0, -320.0)

var jump_velocity: float = 0.0
var jump_gravity: float = 0.0
var fall_gravity: float = 0.0

var _coyote_timer: float = 0.0
var _jump_buffer_timer: float = 0.0

func _ready() -> void:
	_recalculate_jump_physics()
	floor_snap_length = 8.0
	floor_constant_speed = true

func _recalculate_jump_physics() -> void:
	jump_velocity = -((2.0 * jump_height) / time_to_jump_peak)
	jump_gravity = (2.0 * jump_height) / (time_to_jump_peak * time_to_jump_peak)
	fall_gravity = (2.0 * jump_height) / (time_to_jump_descent * time_to_jump_descent)

func _physics_process(delta: float) -> void:
	_update_game_feel_timers(delta)
	_handle_vertical_physics(delta)
	_handle_horizontal_physics(delta)
	_handle_wall_slide()
	move_and_slide()

func _update_game_feel_timers(delta: float) -> void:
	_coyote_timer = coyote_duration if is_on_floor() else maxf(0.0, _coyote_timer - delta)
	if Input.is_action_just_pressed("jump"):
		_jump_buffer_timer = jump_buffer_duration
	else:
		_jump_buffer_timer = maxf(0.0, _jump_buffer_timer - delta)

func _handle_vertical_physics(delta: float) -> void:
	var gravity_force: float = jump_gravity if velocity.y < 0.0 else fall_gravity
	velocity.y += gravity_force * delta

	if _jump_buffer_timer > 0.0:
		if _coyote_timer > 0.0:
			velocity.y = jump_velocity
			_coyote_timer = 0.0
			_jump_buffer_timer = 0.0
		elif is_on_wall_only():
			var wall_dir: float = get_wall_normal().x
			velocity.x = wall_dir * wall_jump_velocity.x
			velocity.y = wall_jump_velocity.y
			_jump_buffer_timer = 0.0

	if Input.is_action_just_released("jump") and velocity.y < 0.0:
		velocity.y *= jump_cut_multiplier

func _handle_horizontal_physics(delta: float) -> void:
	var input_x: float = Input.get_axis("move_left", "move_right")
	var is_grounded: bool = is_on_floor()
	var current_accel: float = acceleration if is_grounded else air_acceleration
	var current_friction: float = friction if is_grounded else air_friction

	if not is_zero_approx(input_x):
		velocity.x = move_toward(velocity.x, input_x * max_speed, current_accel * delta)
	else:
		velocity.x = move_toward(velocity.x, 0.0, current_friction * delta)

func _handle_wall_slide() -> void:
	if is_on_wall_only() and velocity.y > 0.0:
		velocity.y = minf(velocity.y, wall_slide_max_speed)
