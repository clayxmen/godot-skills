# res://test/unit/test_inventory_component.gd
extends GutTest
## Automated GUT Unit Test Suite for InventoryComponent in Godot 4.x

var _inventory: InventoryComponent = null
var _test_item: ItemData = null

func before_each() -> void:
	_inventory = InventoryComponent.new()
	_inventory.max_slots = 4
	add_child_autofree(_inventory)

	_test_item = ItemData.new()
	_test_item.id = &"item_potion"
	_test_item.max_stack_size = 5

	watch_signals(_inventory)

func test_add_item_stacks_correctly() -> void:
	var remainder: int = _inventory.add_item(_test_item, 3)
	assert_eq(remainder, 0)
	assert_eq(_inventory.get_item_count(&"item_potion"), 3)

	remainder = _inventory.add_item(_test_item, 4)
	assert_eq(remainder, 0)
	assert_eq(_inventory.get_item_count(&"item_potion"), 7)
	assert_eq(_inventory.slots[0].count, 5)
	assert_eq(_inventory.slots[1].count, 2)

func test_remove_item_by_id() -> void:
	_inventory.add_item(_test_item, 4)
	var success: bool = _inventory.remove_item_by_id(&"item_potion", 3)

	assert_true(success)
	assert_eq(_inventory.get_item_count(&"item_potion"), 1)
