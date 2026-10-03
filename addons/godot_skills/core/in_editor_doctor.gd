@tool
class_name GodotInEditorDoctor
extends RefCounted

## In-Editor Static Typing & Migration Doctor for Godot 4.x.
## Scans GDScript files in `res://` for type-safety violations, missing annotations, and legacy Godot 3 patterns.

enum Severity { ERROR, WARNING, INFO }

## Runs a comprehensive health audit across all project GDScript files.
static func run_audit(scan_path: String = "res://") -> Dictionary:
	var files: Array[String] = _find_gdscripts(scan_path)
	var issues: Array[Dictionary] = []
	var clean_files: int = 0

	var regex_untyped_func: RegEx = RegEx.new()
	regex_untyped_func.compile(r"^\s*func\s+([a-zA-Z0-9_]+)\s*\([^)]*\)\s*:")

	var regex_untyped_var: RegEx = RegEx.new()
	regex_untyped_var.compile(r"^\s*var\s+([a-zA-Z0-9_]+)\s*=\s*[^:]")

	var regex_legacy_yield: RegEx = RegEx.new()
	regex_legacy_yield.compile(r"\byield\s*\(")

	var regex_legacy_export: RegEx = RegEx.new()
	regex_legacy_export.compile(r"(?<!@)\bexport\s+var\b")

	var regex_legacy_onready: RegEx = RegEx.new()
	regex_legacy_onready.compile(r"(?<!@)\bonready\s+var\b")

	var regex_legacy_kinematic: RegEx = RegEx.new()
	regex_legacy_kinematic.compile(r"\bKinematicBody(2D|3D)?\b")

	var regex_legacy_instance: RegEx = RegEx.new()
	regex_legacy_instance.compile(r"\.instance\s*\(\s*\)")

	for file_path: String in files:
		var file_issues: Array[Dictionary] = _audit_single_file(
			file_path,
			regex_untyped_func,
			regex_untyped_var,
			regex_legacy_yield,
			regex_legacy_export,
			regex_legacy_onready,
			regex_legacy_kinematic,
			regex_legacy_instance
		)
		if file_issues.is_empty():
			clean_files += 1
		else:
			issues.append_array(file_issues)

	return {
		"total_files": files.size(),
		"clean_files": clean_files,
		"issue_count": issues.size(),
		"issues": issues,
		"is_100_percent_clean": (issues.is_empty())
	}

static func _audit_single_file(
	file_path: String,
	re_func: RegEx,
	re_var: RegEx,
	re_yield: RegEx,
	re_export: RegEx,
	re_onready: RegEx,
	re_kinematic: RegEx,
	re_instance: RegEx
) -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	var file: FileAccess = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		return result

	var line_num: int = 0
	while not file.eof_reached():
		line_num += 1
		var line: String = file.get_line()
		var trimmed: String = line.strip_edges()

		# Skip comments and empty lines
		if trimmed.is_empty() or trimmed.begins_with("#"):
			continue

		# 1. Check legacy yield
		if re_yield.search(line) != null:
			result.append({
				"file": file_path,
				"line": line_num,
				"severity": "ERROR",
				"code": trimmed,
				"message": "Legacy 'yield()' is obsolete in Godot 4.",
				"suggestion": "Replace with 'await <signal_or_coroutine>'."
			})

		# 2. Check legacy export var
		if re_export.search(line) != null:
			result.append({
				"file": file_path,
				"line": line_num,
				"severity": "ERROR",
				"code": trimmed,
				"message": "Legacy 'export var' is obsolete in Godot 4.",
				"suggestion": "Replace with '@export var'."
			})

		# 3. Check legacy onready var
		if re_onready.search(line) != null:
			result.append({
				"file": file_path,
				"line": line_num,
				"severity": "ERROR",
				"code": trimmed,
				"message": "Legacy 'onready var' is obsolete in Godot 4.",
				"suggestion": "Replace with '@onready var'."
			})

		# 4. Check legacy KinematicBody
		if re_kinematic.search(line) != null:
			result.append({
				"file": file_path,
				"line": line_num,
				"severity": "ERROR",
				"code": trimmed,
				"message": "KinematicBody is renamed in Godot 4.",
				"suggestion": "Replace with 'CharacterBody2D' or 'CharacterBody3D'."
			})

		# 5. Check legacy .instance()
		if re_instance.search(line) != null:
			result.append({
				"file": file_path,
				"line": line_num,
				"severity": "ERROR",
				"code": trimmed,
				"message": ".instance() is renamed in Godot 4.",
				"suggestion": "Replace with '.instantiate()'."
			})

		# 6. Check untyped function return
		var match_func: RegExMatch = re_func.search(line)
		if match_func != null:
			result.append({
				"file": file_path,
				"line": line_num,
				"severity": "WARNING",
				"code": trimmed,
				"message": "Function '" + match_func.get_string(1) + "' lacks explicit return type.",
				"suggestion": "Add return type annotation, e.g. '-> void:' or '-> bool:'."
			})

		# 7. Check untyped variable declaration
		var match_var: RegExMatch = re_var.search(line)
		if match_var != null:
			result.append({
				"file": file_path,
				"line": line_num,
				"severity": "WARNING",
				"code": trimmed,
				"message": "Variable '" + match_var.get_string(1) + "' is dynamically typed.",
				"suggestion": "Use explicit static type 'var " + match_var.get_string(1) + ": Type = ...' or inferred ':= ...'."
			})

	file.close()
	return result

static func _find_gdscripts(path: String) -> Array[String]:
	var result: Array[String] = []
	var dir: DirAccess = DirAccess.open(path)
	if dir == null:
		return result

	dir.list_dir_begin()
	var file_name: String = dir.get_next()
	while not file_name.is_empty():
		if dir.current_is_dir():
			if not file_name.begins_with(".") and file_name != ".godot":
				var sub_path: String = path.path_join(file_name)
				result.append_array(_find_gdscripts(sub_path))
		else:
			if file_name.ends_with(".gd"):
				result.append(path.path_join(file_name))
		file_name = dir.get_next()
	dir.list_dir_end()
	return result
