# res://src/core/types/quest_resource.gd
class_name QuestResource
extends Resource
## Data-driven Quest Resource for Godot 4.x

enum QuestState { NOT_STARTED, IN_PROGRESS, READY_TO_TURN_IN, COMPLETED, FAILED }
enum ObjectiveType { KILL_ENEMIES, COLLECT_ITEMS, REACH_LOCATION, TALK_TO_NPC }

@export_group("Metadata")
@export var id: StringName = &""
@export var title: String = ""
@export_multiline var description: String = ""

@export_group("Objective")
@export var objective_type: ObjectiveType = ObjectiveType.KILL_ENEMIES
@export var target_id: StringName = &""
@export var target_amount: int = 5
@export var current_amount: int = 0

@export_group("Rewards")
@export var exp_reward: int = 150
@export var gold_reward: int = 50
@export var item_rewards: Array[ItemData] = []

var state: QuestState = QuestState.NOT_STARTED

func advance_progress(amount: int = 1) -> bool:
	if state != QuestState.IN_PROGRESS:
		return false

	current_amount = mini(current_amount + amount, target_amount)
	if current_amount >= target_amount:
		state = QuestState.READY_TO_TURN_IN
		return true
	return false

func get_progress_string() -> String:
	return "%d / %d" % [current_amount, target_amount]
