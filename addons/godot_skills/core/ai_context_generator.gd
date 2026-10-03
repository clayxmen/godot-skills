@tool
class_name GodotAIContextGenerator
extends RefCounted

## Generates and synchronizes multi-agent AI rules (.gemini/, .cursor/, CLAUDE.md, copilot)
## directly inside the Godot Editor without requiring external CLI dependencies.

const CLAUDE_PATH: String = "res://CLAUDE.md"
const COPILOT_PATH: String = "res://.github/copilot-instructions.md"
const CURSOR_DIR: String = "res://.cursor/rules/"
const GEMINI_DIR: String = "res://.gemini/skills/"

## Returns current status of AI configuration files in the active project.
static func get_ai_status() -> Dictionary:
	var has_claude: bool = FileAccess.file_exists(CLAUDE_PATH)
	var has_copilot: bool = FileAccess.file_exists(COPILOT_PATH)
	var has_cursor: bool = DirAccess.dir_exists_absolute(CURSOR_DIR)
	var has_gemini: bool = DirAccess.dir_exists_absolute(GEMINI_DIR)
	
	var gemini_skills_count: int = 0
	if has_gemini:
		var dir: DirAccess = DirAccess.open(GEMINI_DIR)
		if dir != null:
			dir.list_dir_begin()
			var file_name: String = dir.get_next()
			while not file_name.is_empty():
				if dir.current_is_dir() and not file_name.begins_with("."):
					gemini_skills_count += 1
				file_name = dir.get_next()
			dir.list_dir_end()

	return {
		"claude": has_claude,
		"copilot": has_copilot,
		"cursor": has_cursor,
		"gemini": has_gemini,
		"gemini_skills_count": gemini_skills_count,
		"is_fully_configured": (has_claude and has_copilot and has_cursor and has_gemini)
	}

## Generates or refreshes all AI configuration files across all supported agents.
static func generate_all_ai_contexts() -> Dictionary:
	var generated_files: Array[String] = []

	# 1. CLAUDE.md
	if _write_claude_md():
		generated_files.append(CLAUDE_PATH)

	# 2. Copilot Instructions
	if _write_copilot_instructions():
		generated_files.append(COPILOT_PATH)

	# 3. Cursor Rules
	var cursor_count: int = _generate_cursor_rules()
	if cursor_count > 0:
		generated_files.append(CURSOR_DIR + " (" + str(cursor_count) + " rules)")

	# 4. Gemini Skills
	var gemini_count: int = _generate_gemini_skills()
	if gemini_count > 0:
		generated_files.append(GEMINI_DIR + " (" + str(gemini_count) + " skills)")

	return {
		"success": true,
		"generated_files": generated_files,
		"message": "AI Context generation completed successfully! Total agents configured: 4"
	}

static func _write_claude_md() -> bool:
	var content: String = """# Godot 4.x (4.3+) Project Guidelines for Claude Code

## ⚡ Non-Negotiable GDScript 2.0 Invariants
1. **100% Static Typing**: Explicit types on every variable, function parameter, and return value (`-> void:`, `-> bool:`, `var x: int = 0`).
2. **Zero Godot 3 Legacy Code**:
   - ❌ `yield()` -> ✅ `await`
   - ❌ `export var` -> ✅ `@export var`
   - ❌ `onready var` -> ✅ `@onready var`
   - ❌ `KinematicBody2D/3D` -> ✅ `CharacterBody2D/3D`
   - ❌ `instance()` -> ✅ `instantiate()`
   - ❌ `connect("sig", target, "fn")` -> ✅ `sig.connect(target.fn)`
3. **Component-Based Entity Design**: Separate logic into reusable nodes (`HealthComponent`, `HitboxComponent`, `StateMachine`).
4. **Decoupled Architecture**: Use `Events.gd` global signal bus. No tight direct parent references.
5. **Data-Driven**: Use Custom Resources (`extends Resource`) with `@export` fields instead of raw JSON files.

## 🛠 Project Structure
- `res://src/core/`: Global autoloads, base classes, ServiceLocator, EventBus.
- `res://src/components/`: Reusable, atomic gameplay and physics components.
- `res://src/features/`: Domain features (Player, Enemies, Levels, UI, Inventory).
- `res://addons/godot_skills/`: 25 Enterprise Agent Skills & Component Injector.
"""
	return _write_file(CLAUDE_PATH, content)

static func _write_copilot_instructions() -> bool:
	var content: String = """# GitHub Copilot Instructions for Godot 4.x (4.3+)

You are an expert Godot 4 GDScript 2.0 AI Architect. Follow these rules for all code generation:

1. **Strict GDScript 2.0 Static Typing**:
   - Always declare explicit types: `func process_damage(amount: float) -> void:`
   - Use typed arrays `Array[ItemData]` and typed dictionaries `Dictionary[StringName, float]`.
   - Never write untyped variables (`var x = 5`). Use `var x: int = 5` or `var x := 5`.

2. **Godot 4 API Conventions**:
   - CharacterBody: Use `velocity` property and `move_and_slide()` without arguments.
   - Signals: Define typed signals `signal health_changed(new_health: float, max_health: float)` and connect via `sig.connect(callable)`.
   - Coroutines: Use `await get_tree().create_timer(1.0).timeout`. Never use `yield()`.
   - Annotations: `@export`, `@export_range()`, `@onready`, `@tool`, `@rpc`.

3. **Architecture**:
   - Prefer Node composition over inheritance.
   - Use Custom Resources (`extends Resource`) for item databases, enemy stats, and loot tables.
"""
	_ensure_dir("res://.github/")
	return _write_file(COPILOT_PATH, content)

static func _generate_cursor_rules() -> int:
	_ensure_dir(CURSOR_DIR)
	var count: int = 0
	
	# Master General Rule
	var master_rule: String = """---
description: Godot 4.x GDScript 2.0 Coding & Static Typing Standards
globs: *.gd, *.tscn
---
# GDScript 2.0 Rules
- 100% Static Type annotations required.
- Zero Godot 3 syntax allowed.
- Follow Clean Architecture and Component Entity Design.
"""
	if _write_file(CURSOR_DIR + "godot4-master.mdc", master_rule):
		count += 1

	for skill: Dictionary in GodotSkillRegistry.get_all_skills():
		var skill_id: String = String(skill.get("id", ""))
		var title: String = String(skill.get("title", ""))
		var desc: String = String(skill.get("description", ""))
		var rule_content: String = "---\ndescription: " + title + "\nglobs: *.gd\n---\n# " + title + "\n\n" + desc + "\n"
		if _write_file(CURSOR_DIR + skill_id + ".mdc", rule_content):
			count += 1

	return count

static func _generate_gemini_skills() -> int:
	_ensure_dir(GEMINI_DIR)
	var count: int = 0

	for skill: Dictionary in GodotSkillRegistry.get_all_skills():
		var skill_id: String = String(skill.get("id", ""))
		var title: String = String(skill.get("title", ""))
		var desc: String = String(skill.get("description", ""))
		var target_skill_dir: String = GEMINI_DIR + skill_id + "/"
		_ensure_dir(target_skill_dir)

		var skill_md_content: String = ""
		var source_skill_path: String = "res://skills/" + skill_id + "/SKILL.md"

		if FileAccess.file_exists(source_skill_path):
			var src_file: FileAccess = FileAccess.open(source_skill_path, FileAccess.READ)
			if src_file != null:
				skill_md_content = src_file.get_as_text()
				src_file.close()

		if skill_md_content.is_empty():
			skill_md_content = "---\nname: " + skill_id + "\ndescription: " + desc + "\nengine_target: Godot 4.3+\n---\n# " + title + "\n\n" + desc + "\n"

		if _write_file(target_skill_dir + "SKILL.md", skill_md_content):
			count += 1

	return count

static func _ensure_dir(path: String) -> void:
	if not DirAccess.dir_exists_absolute(path):
		DirAccess.make_dir_recursive_absolute(path)

static func _write_file(path: String, content: String) -> bool:
	var file: FileAccess = FileAccess.open(path, FileAccess.WRITE)
	if file == null:
		return false
	file.store_string(content)
	file.close()
	return true
