# res://src/core/services/quest_manager.gd
class_name QuestManager
extends Node
## Global Quest Manager Service for Godot 4.x
## Listens to game-wide events and advances player quest state.

signal quest_started(quest: QuestResource)
signal quest_updated(quest: QuestResource)
signal quest_completed(quest: QuestResource)

var active_quests: Dictionary[StringName, QuestResource] = {}
var completed_quest_ids: Array[StringName] = []

func _ready() -> void:
	if Events and Events.has_signal("enemy_defeated"):
		Events.enemy_defeated.connect(_on_enemy_defeated)

func start_quest(quest_template: QuestResource) -> void:
	if quest_template == null or active_quests.has(quest_template.id) or completed_quest_ids.has(quest_template.id):
		return

	var quest_instance: QuestResource = quest_template.duplicate(true) as QuestResource
	quest_instance.state = QuestResource.QuestState.IN_PROGRESS
	quest_instance.current_amount = 0
	active_quests[quest_instance.id] = quest_instance

	quest_started.emit(quest_instance)

func _on_enemy_defeated(enemy_id: StringName, _exp: int, _pos: Vector3) -> void:
	for quest: QuestResource in active_quests.values():
		if quest.objective_type == QuestResource.ObjectiveType.KILL_ENEMIES and quest.target_id == enemy_id:
			var completed_now: bool = quest.advance_progress(1)
			quest_updated.emit(quest)
			if completed_now and Events.has_signal("notification_requested"):
				Events.notification_requested.emit("Quest Ready!", "%s is ready to turn in." % quest.title, null)

func complete_quest(quest_id: StringName, player_inventory: InventoryComponent) -> bool:
	if not active_quests.has(quest_id):
		return false

	var quest: QuestResource = active_quests[quest_id]
	if quest.state != QuestResource.QuestState.READY_TO_TURN_IN and quest.state != QuestResource.QuestState.IN_PROGRESS:
		return false

	quest.state = QuestResource.QuestState.COMPLETED
	active_quests.erase(quest_id)
	completed_quest_ids.append(quest_id)

	if player_inventory:
		for item: ItemData in quest.item_rewards:
			player_inventory.add_item(item, 1)

	quest_completed.emit(quest)
	return true
