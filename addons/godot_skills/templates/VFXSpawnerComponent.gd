# res://src/core/components/vfx/vfx_spawner_component.gd
class_name VFXSpawnerComponent
extends Node
## Static Utility for Instantiating Self-Cleaning Particle VFX in Godot 4.x

static func spawn_at(vfx_scene: PackedScene, world_position: Vector2, parent_tree: Node = null) -> Node:
	if vfx_scene == null:
		return null

	var instance: Node = vfx_scene.instantiate()
	if parent_tree:
		parent_tree.add_child(instance)
	else:
		Engine.get_main_loop().root.add_child(instance)

	if instance is Node2D:
		(instance as Node2D).global_position = world_position
	elif instance is Node3D:
		(instance as Node3D).global_position = Vector3(world_position.x, 0.0, world_position.y)

	if instance is GPUParticles2D:
		var p2d: GPUParticles2D = instance as GPUParticles2D
		p2d.one_shot = true
		p2d.emitting = true
		p2d.finished.connect(p2d.queue_free)
	elif instance is GPUParticles3D:
		var p3d: GPUParticles3D = instance as GPUParticles3D
		p3d.one_shot = true
		p3d.emitting = true
		p3d.finished.connect(p3d.queue_free)

	return instance
