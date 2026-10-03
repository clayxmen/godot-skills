# res://src/core/components/combat/hitbox_component_2d.gd
class_name HitboxComponent2D
extends Area2D
## 2D Attack Collision Component for Godot 4.x
## Attach to weapons, melee sweeps, projectiles, or hazard zones.

signal hit_landed(hurtbox: HurtboxComponent2D, payload: DamagePayload)

@export var base_damage: float = 15.0
@export var knockback_magnitude: float = 300.0
@export var hitstop_seconds: float = 0.08
@export var is_critical: bool = false
@export var element_type: DamagePayload.ElementType = DamagePayload.ElementType.PHYSICAL

func create_payload(target_position: Vector2) -> DamagePayload:
	var knockback_dir: Vector2 = (target_position - global_position).normalized()
	if is_zero_approx(knockback_dir.length()):
		knockback_dir = Vector2.RIGHT
	var knockback_vector: Vector2 = knockback_dir * knockback_magnitude

	return DamagePayload.new(
		base_damage,
		knockback_vector,
		hitstop_seconds,
		is_critical,
		owner,
		element_type
	)

func notify_hit_landed(hurtbox: HurtboxComponent2D, payload: DamagePayload) -> void:
	hit_landed.emit(hurtbox, payload)
