# res://src/core/types/damage_payload.gd
class_name DamagePayload
extends RefCounted
## Standardized Combat Damage Payload DTO for Godot 4.x

enum ElementType { PHYSICAL, FIRE, ICE, LIGHTNING, POISON, VOID }

var base_damage: float = 10.0
var knockback_force: Vector2 = Vector2.ZERO
var hitstop_duration: float = 0.08
var stun_duration: float = 0.2
var is_critical: bool = false
var element: ElementType = ElementType.PHYSICAL
var attacker: Node = null

func _init(
	p_damage: float = 10.0,
	p_knockback: Vector2 = Vector2.ZERO,
	p_hitstop: float = 0.08,
	p_is_crit: bool = false,
	p_attacker: Node = null,
	p_element: ElementType = ElementType.PHYSICAL
) -> void:
	base_damage = p_damage
	knockback_force = p_knockback
	hitstop_duration = p_hitstop
	is_critical = p_is_crit
	attacker = p_attacker
	element = p_element
