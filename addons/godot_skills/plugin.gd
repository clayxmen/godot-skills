@tool
extends EditorPlugin

## Main EditorPlugin entry point for Godot Skills Suite.
## Registers the Skills Dock panel, menu items, and integrates with the Godot 4 Editor lifecycle.

const DOCK_SCENE_PATH: String = "res://addons/godot_skills/ui/skills_dock.tscn"
const ICON_PATH: String = "res://addons/godot_skills/icon.svg"

var dock_instance: Control = null

func _enter_tree() -> void:
	# 1. Instantiate and add dock to right editor dock panel safely
	if ResourceLoader.exists(DOCK_SCENE_PATH):
		var dock_scene: PackedScene = load(DOCK_SCENE_PATH) as PackedScene
		if dock_scene != null:
			dock_instance = dock_scene.instantiate() as Control
			if dock_instance != null:
				dock_instance.name = "Godot Skills"
				if dock_instance.has_method("set_undo_redo"):
					dock_instance.call("set_undo_redo", get_undo_redo())
				add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_UL, dock_instance)

	# 2. Register Project Tools menu entries
	add_tool_menu_item("Godot Skills: ⚡ 1-Click AI Setup", _on_menu_ai_setup)
	add_tool_menu_item("Godot Skills: 🩺 Run Doctor Audit", _on_menu_doctor_audit)

func _exit_tree() -> void:
	# 1. Remove menu items
	remove_tool_menu_item("Godot Skills: ⚡ 1-Click AI Setup")
	remove_tool_menu_item("Godot Skills: 🩺 Run Doctor Audit")

	# 2. Clean up dock
	if is_instance_valid(dock_instance):
		remove_control_from_docks(dock_instance)
		dock_instance.free()
		dock_instance = null

func _get_plugin_name() -> String:
	return "Godot Skills"

func _get_plugin_icon() -> Texture2D:
	if ResourceLoader.exists(ICON_PATH):
		return load(ICON_PATH) as Texture2D
	return null

func _on_menu_ai_setup() -> void:
	var result: Dictionary = GodotAIContextGenerator.generate_all_ai_contexts()
	print_rich("[color=#20df40][b]⚡ Godot Skills:[/b][/color] %s" % result.get("message", "Generated AI Context."))

func _on_menu_doctor_audit() -> void:
	var report: Dictionary = GodotInEditorDoctor.run_audit("res://")
	var issues: int = int(report.get("issue_count", 0))
	var clean: int = int(report.get("clean_files", 0))
	if issues == 0:
		print_rich("[color=#20df40][b]🩺 Godot Skills Doctor:[/b] 100%% Clean! All %d files passed static type check.[/color]" % clean)
	else:
		print_rich("[color=#ffaa00][b]🩺 Godot Skills Doctor:[/b] Found %d issues across project files.[/color]" % issues)
