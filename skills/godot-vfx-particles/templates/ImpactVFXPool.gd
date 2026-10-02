# res://src/core/services/vfx/impact_vfx_pool.gd
class_name ImpactVFXPool
extends Node
## High-Performance Object Pool for GPUParticles2D in Godot 4.x

@export var vfx_template: PackedScene
@export var initial_pool_size: int = 16

var _available_pool: Array[GPUParticles2D] = []

func _ready() -> void:
	if vfx_template == null:
		return

	for i in range(initial_pool_size):
		var emitter: GPUParticles2D = vfx_template.instantiate() as GPUParticles2D
		if emitter:
			emitter.one_shot = true
			emitter.emitting = false
			emitter.finished.connect(_on_emitter_finished.bind(emitter))
			add_child(emitter)
			_available_pool.append(emitter)

func play_impact(world_pos: Vector2, rotation_angle: float = 0.0) -> void:
	var emitter: GPUParticles2D = null
	if _available_pool.is_empty():
		if vfx_template:
			emitter = vfx_template.instantiate() as GPUParticles2D
			emitter.one_shot = true
			emitter.finished.connect(_on_emitter_finished.bind(emitter))
			add_child(emitter)
	else:
		emitter = _available_pool.pop_back()

	if emitter:
		emitter.global_position = world_pos
		emitter.global_rotation = rotation_angle
		emitter.restart()
		emitter.emitting = true

func _on_emitter_finished(emitter: GPUParticles2D) -> void:
	emitter.emitting = false
	_available_pool.append(emitter)
