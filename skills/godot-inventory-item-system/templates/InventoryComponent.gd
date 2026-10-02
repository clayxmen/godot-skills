# res://src/core/components/inventory_component.gd
class_name InventoryComponent
extends Node
## Production Inventory Manager Component for Godot 4.x
## Handles automatic stacking, slot allocation, item removal, and capacity management.

signal inventory_updated()
signal item_added(item: ItemData, amount: int)
signal item_removed(item: ItemData, amount: int)

@export var max_slots: int = 24
@export var max_carry_weight: float = 100.0

var slots: Array[InventorySlot] = []

func _ready() -> void:
	slots.resize(max_slots)
	for i: int in range(max_slots):
		var slot: InventorySlot = InventorySlot.new()
		slot.slot_changed.connect(_on_slot_changed)
		slots[i] = slot

func _on_slot_changed() -> void:
	inventory_updated.emit()

func add_item(item: ItemData, amount: int = 1) -> int:
	if item == null or amount <= 0:
		return amount

	var remaining: int = amount

	# 1. Fill existing matching stacks
	for slot: InventorySlot in slots:
		if slot.can_stack_with(item):
			var space: int = slot.get_remaining_capacity()
			var to_add: int = mini(remaining, space)
			slot.count += to_add
			remaining -= to_add
			if remaining <= 0:
				break

	# 2. Fill empty slots
	if remaining > 0:
		for slot: InventorySlot in slots:
			if slot.is_empty():
				var to_add: int = mini(remaining, item.max_stack_size)
				slot.item = item
				slot.count = to_add
				remaining -= to_add
				if remaining <= 0:
					break

	var total_added: int = amount - remaining
	if total_added > 0:
		item_added.emit(item, total_added)

	return remaining

func remove_item_by_id(item_id: StringName, amount: int = 1) -> bool:
	if get_item_count(item_id) < amount:
		return false

	var remaining: int = amount
	for slot: InventorySlot in slots:
		if not slot.is_empty() and slot.item.id == item_id:
			if slot.count >= remaining:
				slot.count -= remaining
				remaining = 0
				break
			else:
				remaining -= slot.count
				slot.count = 0

	return remaining == 0

func get_item_count(item_id: StringName) -> int:
	var total: int = 0
	for slot: InventorySlot in slots:
		if not slot.is_empty() and slot.item.id == item_id:
			total += slot.count
	return total

func swap_slots(index_a: int, index_b: int) -> void:
	if index_a < 0 or index_a >= max_slots or index_b < 0 or index_b >= max_slots:
		return
	var temp_item: ItemData = slots[index_a].item
	var temp_count: int = slots[index_a].count
	slots[index_a].item = slots[index_b].item
	slots[index_a].count = slots[index_b].count
	slots[index_b].item = temp_item
	slots[index_b].count = temp_count
