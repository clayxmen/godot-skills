# res://src/core/types/inventory_slot.gd
class_name InventorySlot
extends RefCounted
## Observable Inventory Slot Container for Godot 4.x

signal slot_changed()

var item: ItemData = null:
	set(value):
		item = value
		if item == null:
			count = 0
		slot_changed.emit()

var count: int = 0:
	set(value):
		count = max(0, value)
		if count == 0:
			item = null
		slot_changed.emit()

func is_empty() -> bool:
	return item == null or count <= 0

func can_stack_with(other_item: ItemData) -> bool:
	if is_empty() or other_item == null:
		return false
	return item.id == other_item.id and count < item.max_stack_size

func get_remaining_capacity() -> int:
	if is_empty() or item == null:
		return 999
	return item.max_stack_size - count
