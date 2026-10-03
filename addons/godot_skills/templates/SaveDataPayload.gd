# res://src/core/types/save_data_payload.gd
class_name SaveDataPayload
extends Resource
## Production Save State DTO for Godot 4.x

@export var schema_version: int = 1
@export var save_timestamp: int = 0
@export var playtime_seconds: float = 0.0
@export var current_scene_path: String = ""

@export_group("Player State")
@export var player_position: Vector3 = Vector3.ZERO
@export var player_health: float = 100.0
@export var player_max_health: float = 100.0
@export var player_gold: int = 0

@export_group("Subsystem State")
@export var inventory_slots: Array[Dictionary] = []
@export var active_quests: Array[Dictionary] = []
@export var completed_quest_ids: Array[StringName] = []
@export var unlocked_flags: Dictionary = {}

func to_dict() -> Dictionary:
	return {
		"schema_version": schema_version,
		"save_timestamp": int(Time.get_unix_time_from_system()),
		"playtime_seconds": playtime_seconds,
		"current_scene_path": current_scene_path,
		"player": {
			"pos_x": player_position.x,
			"pos_y": player_position.y,
			"pos_z": player_position.z,
			"health": player_health,
			"max_health": player_max_health,
			"gold": player_gold
		},
		"inventory": inventory_slots,
		"quests": {
			"active": active_quests,
			"completed": completed_quest_ids
		},
		"flags": unlocked_flags
	}

func from_dict(dict: Dictionary) -> void:
	schema_version = dict.get("schema_version", 1)
	save_timestamp = dict.get("save_timestamp", 0)
	playtime_seconds = dict.get("playtime_seconds", 0.0)
	current_scene_path = dict.get("current_scene_path", "")

	var p_data: Dictionary = dict.get("player", {})
	player_position = Vector3(p_data.get("pos_x", 0.0), p_data.get("pos_y", 0.0), p_data.get("pos_z", 0.0))
	player_health = p_data.get("health", 100.0)
	player_max_health = p_data.get("max_health", 100.0)
	player_gold = p_data.get("gold", 0)

	inventory_slots = dict.get("inventory", [])
	var q_data: Dictionary = dict.get("quests", {})
	active_quests = q_data.get("active", [])
	completed_quest_ids = q_data.get("completed", [])
	unlocked_flags = dict.get("flags", {})
