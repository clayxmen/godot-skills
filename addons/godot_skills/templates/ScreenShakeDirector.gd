# res://src/core/services/screen_shake_director.gd
class_name ScreenShakeDirector
extends Node
## Perlin Noise Trauma-based Screen Shake Engine for Godot 4.x

@export var camera: Camera2D
@export var max_offset: Vector2 = Vector2(24.0, 16.0)
@export var max_roll_degrees: float = 4.0
@export var trauma_decay: float = 1.4

var trauma: float = 0.0
var _noise: FastNoiseLite = FastNoiseLite.new()
var _noise_y: float = 0.0

func _ready() -> void:
	_noise.noise_type = FastNoiseLite.TYPE_PERLIN
	_noise.frequency = 0.05

## Adds trauma to screen shake (clamped to 1.0).
func add_trauma(amount: float) -> void:
	trauma = minf(1.0, trauma + amount)

func _process(delta: float) -> void:
	if not camera or is_zero_approx(trauma):
		return

	trauma = maxf(0.0, trauma - trauma_decay * delta)
	var shake_amount: float = trauma * trauma

	_noise_y += delta * 60.0
	camera.offset.x = max_offset.x * shake_amount * _noise.get_noise_2d(10.0, _noise_y)
	camera.offset.y = max_offset.y * shake_amount * _noise.get_noise_2d(100.0, _noise_y)
	camera.rotation = deg_to_rad(max_roll_degrees * shake_amount * _noise.get_noise_2d(200.0, _noise_y))
