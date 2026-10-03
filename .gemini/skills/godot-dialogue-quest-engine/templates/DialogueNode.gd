# res://src/core/types/dialogue_node.gd
class_name DialogueNode
extends Resource
## Data-driven Branching Dialogue Node for Godot 4.x

@export var id: StringName = &""
@export var speaker_name: String = ""
@export var speaker_portrait: Texture2D
@export_multiline var dialogue_text: String = ""
@export var next_node_id: StringName = &""
@export var quest_trigger_id: StringName = &""
