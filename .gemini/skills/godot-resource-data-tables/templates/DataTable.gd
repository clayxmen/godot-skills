# res://src/core/types/data_table.gd
class_name DataTable
extends Resource
## Indexed Resource Data Table Container for Godot 4.x

@export var records: Array[Resource] = []:
	set(value):
		records = value
		_rebuild_index()

var _index_map: Dictionary[StringName, Resource] = {}

func _rebuild_index() -> void:
	_index_map.clear()
	for res: Resource in records:
		if res == null:
			continue
		var id: StringName = &""
		if "id" in res:
			id = res.get("id")
		elif "name" in res:
			id = StringName(res.get("name"))
		else:
			id = StringName(res.resource_name)

		if not id.is_empty():
			_index_map[id] = res

func get_record(id: StringName) -> Resource:
	if _index_map.is_empty() and not records.is_empty():
		_rebuild_index()
	return _index_map.get(id)

func has_record(id: StringName) -> bool:
	if _index_map.is_empty() and not records.is_empty():
		_rebuild_index()
	return _index_map.has(id)
