# res://src/core/services/data/csv_resource_importer.gd
class_name CSVResourceImporter
extends RefCounted
## Automated CSV to Custom Resource (.tres) Importer for Godot 4.x

static func import_items_from_csv(csv_path: String) -> Array[ItemData]:
	var result: Array[ItemData] = []
	var file: FileAccess = FileAccess.open(csv_path, FileAccess.READ)
	if file == null:
		push_error("CSVResourceImporter: Cannot open CSV file: %s" % csv_path)
		return result

	var headers: PackedStringArray = file.get_csv_line()

	while not file.eof_reached():
		var row: PackedStringArray = file.get_csv_line()
		if row.size() < headers.size() or row[0].strip_edges().is_empty():
			continue

		var item: ItemData = ItemData.new()
		for i in range(mini(headers.size(), row.size())):
			var header: String = headers[i].strip_edges()
			var val: String = row[i].strip_edges()

			match header:
				"id": item.id = StringName(val)
				"display_name": item.display_name = val
				"description": item.description = val
				"max_stack_size": item.max_stack_size = int(val)
				"gold_value": item.gold_value = int(val)

		result.append(item)

	file.close()
	return result
