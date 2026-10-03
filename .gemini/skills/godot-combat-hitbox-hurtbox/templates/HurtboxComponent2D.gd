# res://src/core/components/combat/hurtbox_component_2d.gd
class_name HurtboxComponent2D
extends Area2D
## 2D Damage Reception Component for Godot 4.x
## Connects incoming attack collisions to HealthComponent and handles i-frames.

signal payload_received(payload: DamagePayload)

@export var health_component: HealthComponent
@export var invulnerability_duration: float = 0.4

var _is_invulnerable: bool = false
var _invuln_timer: float = 0.0

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _physics_process(delta: float) -> void:
	if _is_invulnerable:
		_invuln_timer -= delta
		if _invuln_timer <= 0.0:
			_is_invulnerable = false

func _on_area_entered(area: Area2D) -> void:
	if _is_invulnerable or not (area is HitboxComponent2D):
		return

	var hitbox: HitboxComponent2D = area as HitboxComponent2D
	var payload: DamagePayload = hitbox.create_payload(global_position)

	if health_component and health_component.is_alive():
		health_component.apply_damage(payload.base_damage, payload.attacker)

	if invulnerability_duration > 0.0:
		_is_invulnerable = true
		_invuln_timer = invulnerability_duration

	payload_received.emit(payload)
	hitbox.notify_hit_landed(self, payload)
