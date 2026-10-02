# res://test/unit/test_health_component.gd
extends GutTest
## Automated GUT Unit Test Suite for HealthComponent in Godot 4.x

var _health_component: HealthComponent = null

func before_each() -> void:
	_health_component = HealthComponent.new()
	_health_component.max_health = 100.0
	_health_component.start_health = 100.0
	add_child_autofree(_health_component)
	watch_signals(_health_component)

func test_initial_health_matches_max_health() -> void:
	assert_eq(_health_component.current_health, 100.0)
	assert_true(_health_component.is_alive())

func test_apply_damage_decreases_health_and_emits_signals() -> void:
	_health_component.apply_damage(35.0)

	assert_eq(_health_component.current_health, 65.0)
	assert_signal_emitted(_health_component, "damaged")
	assert_signal_emitted(_health_component, "health_changed")
	assert_signal_not_emitted(_health_component, "health_depleted")

func test_apply_lethal_damage_triggers_death() -> void:
	_health_component.apply_damage(150.0)

	assert_eq(_health_component.current_health, 0.0)
	assert_false(_health_component.is_alive())
	assert_signal_emitted(_health_component, "health_depleted")

func test_invulnerable_entity_ignores_damage() -> void:
	_health_component.is_invulnerable = true
	_health_component.apply_damage(50.0)

	assert_eq(_health_component.current_health, 100.0)
	assert_signal_not_emitted(_health_component, "damaged")
