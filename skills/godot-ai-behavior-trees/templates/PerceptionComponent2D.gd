# res://src/core/components/ai/perception_component_2d.gd
class_name PerceptionComponent2D
extends Node2D
## Sensory Perception Component (Vision Cone & Line-of-Sight) for Godot 4.x

signal target_spotted(target: Node2D)
signal target_lost()
signal alert_level_changed(new_level: AlertLevel)

enum AlertLevel { UNAWARE, SUSPICIOUS, ALERT, COMBAT }

@export_group("Vision Settings")
@export var vision_range: float = 350.0
@export var vision_angle_degrees: float = 90.0
@export var raycast: RayCast2D
@export var target_group: StringName = &"player"

@export_group("Alert Dynamics")
@export var suspicion_build_rate: float = 1.5
@export var suspicion_decay_rate: float = 0.5

var current_alert_level: AlertLevel = AlertLevel.UNAWARE
var suspicion_meter: float = 0.0
var current_target: Node2D = null

func _physics_process(delta: float) -> void:
	var potential_target: Node2D = _find_target_in_vision_cone()

	if potential_target != null:
		suspicion_meter = minf(1.0, suspicion_meter + suspicion_build_rate * delta)
		if suspicion_meter >= 1.0 and current_alert_level != AlertLevel.COMBAT:
			_set_alert_level(AlertLevel.COMBAT)
			current_target = potential_target
			target_spotted.emit(current_target)
		elif current_alert_level == AlertLevel.UNAWARE:
			_set_alert_level(AlertLevel.SUSPICIOUS)
	else:
		suspicion_meter = maxf(0.0, suspicion_meter - suspicion_decay_rate * delta)
		if is_zero_approx(suspicion_meter) and current_alert_level != AlertLevel.UNAWARE:
			_set_alert_level(AlertLevel.UNAWARE)
			current_target = null
			target_lost.emit()

func _find_target_in_vision_cone() -> Node2D:
	var targets: Array[Node] = get_tree().get_nodes_in_group(target_group)
	for node: Node in targets:
		if not (node is Node2D):
			continue
		var candidate: Node2D = node as Node2D
		var to_target: Vector2 = candidate.global_position - global_position
		var distance: float = to_target.length()

		if distance > vision_range:
			continue

		var forward: Vector2 = Vector2.RIGHT.rotated(global_rotation)
		var angle_to_target: float = rad_to_deg(abs(forward.angle_to(to_target)))

		if angle_to_target <= vision_angle_degrees * 0.5:
			if raycast:
				raycast.global_position = global_position
				raycast.target_position = raycast.to_local(candidate.global_position)
				raycast.force_raycast_update()
				if not raycast.is_colliding() or raycast.get_collider() == candidate:
					return candidate
			else:
				return candidate
	return null

func _set_alert_level(new_level: AlertLevel) -> void:
	if current_alert_level != new_level:
		current_alert_level = new_level
		alert_level_changed.emit(current_alert_level)
