# res://src/core/types/item_data.gd
class_name ItemData
extends Resource
## Production Custom Resource Data Template for Godot 4.x
## Represents a serializable, typed inventory item or loot definition.

enum ItemRarity { COMMON, UNCOMMON, RARE, EPIC, LEGENDARY }
enum ItemCategory { CONSUMABLE, WEAPON, ARMOR, MATERIAL, QUEST }

@export_group("Identity")
@export var id: StringName = &""
@export var display_name: String = ""
@export_multiline var description: String = ""
@export var icon: Texture2D

@export_group("Classification")
@export var category: ItemCategory = ItemCategory.CONSUMABLE
@export var rarity: ItemRarity = ItemRarity.COMMON
@export_range(1, 999, 1) var max_stack_size: int = 99

@export_group("Economy & Stats")
@export_range(0, 1000000, 1) var gold_value: int = 10
@export var stat_modifiers: Dictionary[StringName, float] = {}

## Formats item title with rarity-appropriate BBCode color string.
func get_formatted_title() -> String:
	var color_hex: String = "#ffffff"
	match rarity:
		ItemRarity.COMMON: color_hex = "#b0b0b0"
		ItemRarity.UNCOMMON: color_hex = "#20df40"
		ItemRarity.RARE: color_hex = "#0088ff"
		ItemRarity.EPIC: color_hex = "#9d00ff"
		ItemRarity.LEGENDARY: color_hex = "#ffaa00"
	return "[color=%s]%s[/color]" % [color_hex, display_name]
