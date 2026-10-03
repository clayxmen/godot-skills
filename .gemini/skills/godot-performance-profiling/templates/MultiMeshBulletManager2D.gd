# res://src/core/services/vfx/multimesh_bullet_manager_2d.gd
class_name MultiMeshBulletManager2D
extends MultiMeshInstance2D
## High-Performance MultiMesh Bullet Particle Engine (50,000+ Bullets in 1 Draw Call)

@export var max_bullets: int = 10000

var _bullets: Array[Dictionary] = []
var _active_count: int = 0

func _ready() -> void:
	multimesh.instance_count = max_bullets
	multimesh.visible_instance_count = 0

	for i in range(max_bullets):
		_bullets.append({
			"pos": Vector2.ZERO,
			"vel": Vector2.ZERO,
			"alive": false
		})

func spawn_bullet(pos: Vector2, vel: Vector2) -> void:
	for i in range(max_bullets):
		if not _bullets[i]["alive"]:
			_bullets[i]["pos"] = pos
			_bullets[i]["vel"] = vel
			_bullets[i]["alive"] = true
			_active_count = maxi(_active_count, i + 1)
			return

func _physics_process(delta: float) -> void:
	var live_count: int = 0
	var screen_rect: Rect2 = get_viewport_rect()

	for i in range(_active_count):
		if _bullets[i]["alive"]:
			_bullets[i]["pos"] += _bullets[i]["vel"] * delta
			
			if not screen_rect.has_point(_bullets[i]["pos"]):
				_bullets[i]["alive"] = false
				continue

			var xform: Transform2D = Transform2D(0.0, _bullets[i]["pos"])
			multimesh.set_instance_transform_2d(i, xform)
			live_count = i + 1

	multimesh.visible_instance_count = live_count
