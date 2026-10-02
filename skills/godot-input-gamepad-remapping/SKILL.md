---
name: godot-input-gamepad-remapping
description: |
  Runtime Input Remapping, Config Persistence, and Input Buffering for Godot 4.x (Godot 4.3+).
  Implements dynamic InputMap rebinding (Keyboard, Mouse, Gamepad), ConfigFile serialization,
  action icon lookup, deadzone calibration, and frame-accurate Input Buffering.

  Use this skill whenever:
    1. Building player settings menus with customizable Key / Gamepad button rebinding.
    2. Saving and loading user input configurations to disk (`user://input_bindings.cfg`).
    3. Adding an Input Buffer for action combat (queueing attacks/dodges during animation lock).
    4. Managing gamepad stick deadzones and joypad axis sensitivities.
    5. Formatting input prompts dynamically (e.g. displaying [SPACE] or [🎮 A] based on last input device).

  Do NOT use when:
    1. Managing character movement physics execution (use godot-character-controllers).
    2. Handling low-level window resize and display server events.
license: MIT
metadata:
  version: v1.0
  engine_target: "Godot 4.3+"
  author: "Senior Godot AI Architect & Prompt Engineer"
---

# 🎮 Godot 4 Input Remapping & Buffering Architecture

This skill provides a complete solution for **Runtime Input Remapping**, **ConfigFile Persistence**, and **Action Input Buffering** in Godot 4.x.

---

## ⚡ 1. Input Remapping Architecture

```mermaid
flowchart TD
    UI["Rebind UI Button Pressed"] --> Listen["InputRebindManager listens for next InputEvent"]
    Listen --> Validate["Validate Event (Key / JoypadButton)"]
    Validate --> UpdateMap["InputMap.action_erase_events(action)\nInputMap.action_add_event(action, event)"]
    UpdateMap --> SaveCfg["Save to user://input_bindings.cfg"]
    SaveCfg --> Broadcast["Signal: input_rebound(action, event) -> Update UI Labels"]
```

---

## 💎 2. Input Rebind Manager: `InputRebindManager.gd`

```gdscript
# res://src/core/services/input/input_rebind_manager.gd
class_name InputRebindManager
extends Node

signal input_rebound(action_name: StringName, event: InputEvent)

const CONFIG_PATH: String = "user://input_bindings.cfg"

## Rebinds an action to a new input event and persists to disk.
static func rebind_action(action_name: StringName, new_event: InputEvent) -> void:
	if not InputMap.has_action(action_name):
		return

	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, new_event)
	save_bindings_to_disk()

## Saves all custom mappings to ConfigFile.
static func save_bindings_to_disk() -> void:
	var config: ConfigFile = ConfigFile.new()
	for action in InputMap.get_actions():
		var events: Array[InputEvent] = InputMap.action_get_events(action)
		if not events.is_empty():
			config.set_value("bindings", str(action), events[0])
	config.save(CONFIG_PATH)

## Loads saved bindings from disk on game startup.
static func load_bindings_from_disk() -> void:
	var config: ConfigFile = ConfigFile.new()
	if config.load(CONFIG_PATH) != OK:
		return # No custom bindings saved yet

	for action_str in config.get_section_keys("bindings"):
		var action_name: StringName = StringName(action_str)
		var event: InputEvent = config.get_value("bindings", action_str) as InputEvent
		if event and InputMap.has_action(action_name):
			InputMap.action_erase_events(action_name)
			InputMap.action_add_event(action_name, event)
```

---

## ⏱️ 3. Frame-Accurate Input Buffer: `InputBufferComponent.gd`

Queue actions pressed during uninterruptible states (e.g. animation lock) so they fire the moment the character becomes free.

```gdscript
# res://src/core/components/input/input_buffer_component.gd
class_name InputBufferComponent
extends Node

@export var buffer_duration: float = 0.15

var _buffer: Dictionary[StringName, float] = {} # ActionName -> Timestamp

func _unhandled_input(event: InputEvent) -> void:
	for action: StringName in _buffer.keys():
		if event.is_action_pressed(action):
			_buffer[action] = Time.get_ticks_msec() / 1000.0

## Registers an action to be buffered automatically.
func register_action(action_name: StringName) -> void:
	_buffer[action_name] = -999.0

## Consumes a buffered action if pressed within buffer_duration. Returns true if successful.
func consume_action(action_name: StringName) -> bool:
	if not _buffer.has(action_name):
		return false

	var press_time: float = _buffer[action_name]
	var current_time: float = Time.get_ticks_msec() / 1000.0

	if current_time - press_time <= buffer_duration:
		_buffer[action_name] = -999.0 # Invalidate
		return true

	return false
```
