# res://src/core/singletons/events.gd
extends Node
## Global Typed Event Bus for Godot 4.x
## Register this file as an AutoLoad under the name 'Events'.

# ==============================================================================
# ⚔️ GAMEPLAY SIGNALS
# ==============================================================================
signal entity_damaged(target: Node, amount: float, source: Node)
signal player_health_changed(current: float, max_val: float)
signal player_died()
signal enemy_defeated(enemy_id: StringName, exp_reward: int, position: Vector3)
signal stage_completed(stage_index: int, score: int)

# ==============================================================================
# 🖥️ UI / HUD SIGNALS
# ==============================================================================
signal damage_number_spawned(world_pos: Vector3, damage_amount: float, is_critical: bool)
signal menu_toggled(menu_name: StringName, is_open: bool)
signal notification_requested(title: String, message: String, icon: Texture2D)

# ==============================================================================
# 🎵 AUDIO & VFX SIGNALS
# ==============================================================================
signal sfx_playback_requested(sfx_id: StringName, world_pos: Vector3, pitch_variance: float)
signal bgm_crossfade_requested(track_id: StringName, fade_duration_seconds: float)
signal camera_shake_requested(trauma_intensity: float, decay_rate: float)
