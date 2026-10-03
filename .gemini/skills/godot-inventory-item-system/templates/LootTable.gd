# res://src/core/types/loot_table.gd
class_name LootTable
extends Resource
## Weighted Random Loot Table Generator for Godot 4.x

@export var min_item_drops: int = 1
@export var max_item_drops: int = 3
@export var drop_entries: Array[LootDropEntry] = []

func roll_loot() -> Array[Dictionary]:
	var results: Array[Dictionary] = []
	if drop_entries.is_empty():
		return results

	var num_drops: int = randi_range(min_item_drops, max_item_drops)
	var total_weight: float = 0.0
	for entry: LootDropEntry in drop_entries:
		total_weight += entry.weight

	for i: int in range(num_drops):
		var roll: float = randf_range(0.0, total_weight)
		var cumulative: float = 0.0
		for entry: LootDropEntry in drop_entries:
			cumulative += entry.weight
			if roll <= cumulative:
				if randf() <= entry.chance:
					var quantity: int = randi_range(entry.min_quantity, entry.max_quantity)
					results.append({"item": entry.item, "quantity": quantity})
				break

	return results
