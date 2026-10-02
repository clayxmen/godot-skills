# res://src/core/components/health_component.gd
class_name HealthComponent
extends Node
## Universal Health & Vitality Component for Godot 4.x
## Attach this component to any entity (Player, Enemy, Breakable) that requires hitpoints.

signal health_depleted()
signal health_changed(new_health: float, max_health: float, delta: float)
signal damaged(amount: float, source: Node)
signal healed(amount: float)

@export_group("Attributes")
@export var max_health: float = 100.0:
	set(value):
		max_health = maxf(1.0, value)
		current_health = minf(current_health, max_health)

@export var start_health: float = 100.0
@export var is_invulnerable: bool = false

var current_health: float = 0.0

func _ready() -> void:
	current_health = clampf(start_health, 0.0, max_health)

## Applies incoming damage, evaluates invulnerability, and fires signals.
func apply_damage(amount: float, source: Node = null) -> void:
	if is_invulnerable or current_health <= 0.0 or amount <= 0.0:
		return

	var actual_damage: float = minf(amount, current_health)
	current_health -= actual_damage

	damaged.emit(actual_damage, source)
	health_changed.emit(current_health, max_health, -actual_damage)

	if is_zero_approx(current_health) or current_health <= 0.0:
		current_health = 0.0
		health_depleted.emit()

## Restores hitpoints up to max_health.
func apply_healing(amount: float) -> void:
	if current_health <= 0.0 or amount <= 0.0:
		return

	var previous_health: float = current_health
	current_health = minf(current_health + amount, max_health)
	var delta: float = current_health - previous_health

	if delta > 0.0:
		healed.emit(delta)
		health_changed.emit(current_health, max_health, delta)

## Returns true if current health is greater than 0.
func is_alive() -> bool:
	return current_health > 0.0

## Returns the health percentage as a 0.0 - 1.0 ratio.
func get_health_ratio() -> float:
	return current_health / max_health if max_health > 0.0 else 0.0
