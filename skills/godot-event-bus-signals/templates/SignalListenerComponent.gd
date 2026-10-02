# res://src/core/components/signal_listener_component.gd
class_name SignalListenerComponent
extends Node
## Declarative Signal Listener Component for Godot 4.x
## Attach to nodes that need structured event subscription and automatic unsubscription.

@export var is_active: bool = true

func _ready() -> void:
	if is_active:
		_subscribe_to_events()

func _exit_tree() -> void:
	_unsubscribe_from_events()

## Override in subclasses to bind domain-specific event handlers.
func _subscribe_to_events() -> void:
	pass

## Override in subclasses to unbind dynamic connections if needed.
func _unsubscribe_from_events() -> void:
	pass
