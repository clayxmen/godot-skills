# res://src/core/components/state_machine/state_machine.gd
class_name StateMachine
extends Node
## Hierarchical Finite State Machine Container for Godot 4.x
## Automatically indexes child State nodes and routes lifecycle events.

signal state_changed(old_state: StringName, new_state: StringName)

@export var initial_state: State
@export var debug_logging: bool = false

var current_state: State = null
var states: Dictionary[StringName, State] = {}
var state_history: Array[StringName] = []

@onready var actor: Node = get_parent()

func _ready() -> void:
	for child in get_children():
		if child is State:
			var state_node: State = child as State
			var key: StringName = StringName(state_node.name.to_snake_case())
			states[key] = state_node
			state_node.initialize(actor, self)
			state_node.transitioned.connect(_on_transition.bind(state_node))

	if initial_state:
		change_state_to(initial_state)
	elif not states.is_empty():
		change_state_by_name(states.keys()[0])

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)

func change_state_to(target_state: State, payload: Dictionary = {}) -> void:
	if target_state == null or target_state == current_state:
		return

	var old_state_name: StringName = &""
	if current_state:
		old_state_name = StringName(current_state.name.to_snake_case())
		current_state.exit()

	state_history.push_front(old_state_name)
	if state_history.size() > 10:
		state_history.pop_back()

	current_state = target_state
	var new_state_name: StringName = StringName(current_state.name.to_snake_case())

	if debug_logging:
		print("[StateMachine] %s: %s -> %s" % [actor.name, old_state_name, new_state_name])

	current_state.enter(payload)
	state_changed.emit(old_state_name, new_state_name)

func change_state_by_name(state_name: StringName, payload: Dictionary = {}) -> void:
	assert(states.has(state_name), "StateMachine: Missing state '%s'" % state_name)
	change_state_to(states[state_name], payload)

func _on_transition(next_state_name: StringName, payload: Dictionary, sender: State) -> void:
	if sender == current_state:
		change_state_by_name(next_state_name, payload)
