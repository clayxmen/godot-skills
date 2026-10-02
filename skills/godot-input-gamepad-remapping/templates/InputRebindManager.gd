# res://src/core/services/input/input_rebind_manager.gd
class_name InputRebindManager
extends Node
## Runtime InputMap Rebinding & ConfigFile Persistence for Godot 4.x

signal input_rebound(action_name: StringName, event: InputEvent)

const CONFIG_PATH: String = "user://input_bindings.cfg"

static func rebind_action(action_name: StringName, new_event: InputEvent) -> void:
	if not InputMap.has_action(action_name):
		return

	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, new_event)
	save_bindings_to_disk()

static func save_bindings_to_disk() -> void:
	var config: ConfigFile = ConfigFile.new()
	for action in InputMap.get_actions():
		var events: Array[InputEvent] = InputMap.action_get_events(action)
		if not events.is_empty():
			config.set_value("bindings", str(action), events[0])
	config.save(CONFIG_PATH)

static func load_bindings_from_disk() -> void:
	var config: ConfigFile = ConfigFile.new()
	if config.load(CONFIG_PATH) != OK:
		return

	for action_str in config.get_section_keys("bindings"):
		var action_name: StringName = StringName(action_str)
		var event: InputEvent = config.get_value("bindings", action_str) as InputEvent
		if event and InputMap.has_action(action_name):
			InputMap.action_erase_events(action_name)
			InputMap.action_add_event(action_name, event)
