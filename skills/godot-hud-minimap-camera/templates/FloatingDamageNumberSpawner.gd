# res://src/ui/hud/floating_damage_number_spawner.gd
class_name FloatingDamageNumberSpawner
extends Node2D
## World-Space Floating Combat Text Spawner for Godot 4.x

@export var float_distance: float = 48.0
@export var duration: float = 0.65

func spawn_damage(world_pos: Vector2, amount: float, is_crit: bool = false) -> void:
	var label: Label = Label.new()
	label.text = str(int(amount))
	label.global_position = world_pos + Vector2(randf_range(-12.0, 12.0), -10.0)
	label.z_index = 100

	if is_crit:
		label.modulate = Color(1.0, 0.85, 0.1)
		label.scale = Vector2(1.4, 1.4)
	else:
		label.modulate = Color(1.0, 1.0, 1.0)

	add_child(label)

	var target_pos: Vector2 = label.position + Vector2(randf_range(-20.0, 20.0), -float_distance)
	var tw: Tween = create_tween().set_parallel(true)
	
	tw.tween_property(label, "position", target_pos, duration).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tw.tween_property(label, "modulate:a", 0.0, duration).set_delay(duration * 0.4)
	tw.chain().tween_callback(label.queue_free)
