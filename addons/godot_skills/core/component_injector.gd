@tool
class_name GodotComponentInjector
extends RefCounted

## Utility service to inject pre-tested, 100% type-safe components into active Godot Editor scenes.
## Handles template copy to `res://src/components/`, dependency resolution, node instantiation, and UndoRedo registration.

const TEMPLATES_DIR: String = "res://addons/godot_skills/templates/"
const DEST_DIR: String = "res://src/components/"

## Injects a component by its identifier into the target parent node within the edited scene.
static func inject_component(component_id: StringName, parent_node: Node, undo_redo: Object = null) -> Dictionary:
	if not is_instance_valid(parent_node):
		return {"success": false, "message": "Target parent node is invalid."}
	
	var scene_root: Node = parent_node.owner if parent_node.owner != null else parent_node
	if not is_instance_valid(scene_root):
		return {"success": false, "message": "Could not find active scene root."}

	var comp_def: Dictionary = _find_component_def(component_id)
	if comp_def.is_empty():
		return {"success": false, "message": "Component definition not found: " + String(component_id)}

	# Step 1: Ensure destination directory exists
	_ensure_dir(DEST_DIR)

	# Step 2: Copy main script and dependencies
	var script_file: String = comp_def.get("script_file", "")
	var copy_res: bool = _ensure_template_copied(script_file)
	if not copy_res:
		return {"success": false, "message": "Failed to copy template script: " + script_file}

	_copy_component_dependencies(component_id)

	# Step 3: Instantiate node
	var node_type: String = comp_def.get("node_type", "Node")
	var node_name: String = comp_def.get("name", "NewComponent")
	var script_path: String = DEST_DIR + script_file

	var new_node: Node = _create_typed_node(node_type)
	if not is_instance_valid(new_node):
		return {"success": false, "message": "Failed to instantiate node of type: " + node_type}

	new_node.name = node_name

	if ResourceLoader.exists(script_path):
		var script_res: Script = load(script_path) as Script
		if script_res != null:
			new_node.set_script(script_res)

	# Step 4: Add helper sub-nodes if needed (e.g. CollisionShape2D for Area2D)
	if node_type == "Area2D":
		var col_shape: CollisionShape2D = CollisionShape2D.new()
		col_shape.name = "CollisionShape2D"
		var rect: RectangleShape2D = RectangleShape2D.new()
		rect.size = Vector2(32.0, 32.0)
		col_shape.shape = rect
		new_node.add_child(col_shape)
		col_shape.owner = scene_root

	# Step 5: Add to parent with UndoRedo
	if undo_redo != null:
		undo_redo.create_action("Inject Godot Skill Component: " + node_name)
		undo_redo.add_do_method(parent_node, "add_child", new_node)
		undo_redo.add_do_reference(new_node)
		undo_redo.add_do_property(new_node, "owner", scene_root)
		undo_redo.add_undo_method(parent_node, "remove_child", new_node)
		undo_redo.commit_action()
	else:
		parent_node.add_child(new_node)
		new_node.owner = scene_root

	return {
		"success": true,
		"message": "Successfully injected " + node_name + " into " + parent_node.name,
		"node": new_node
	}

static func _find_component_def(component_id: StringName) -> Dictionary:
	for comp: Dictionary in GodotSkillRegistry.get_injectable_components():
		if (comp.get("id") as StringName) == component_id:
			return comp
	return {}

static func _ensure_template_copied(file_name: String) -> bool:
	var src_path: String = TEMPLATES_DIR + file_name
	var dest_path: String = DEST_DIR + file_name

	if FileAccess.file_exists(dest_path):
		return true # Already in project

	if not FileAccess.file_exists(src_path):
		# Fallback: check skills/ directory
		var fallback_found: bool = false
		for skill: Dictionary in GodotSkillRegistry.get_all_skills():
			var skill_id: String = String(skill.get("id", ""))
			var test_path: String = "res://skills/" + skill_id + "/templates/" + file_name
			if FileAccess.file_exists(test_path):
				src_path = test_path
				fallback_found = true
				break
		if not fallback_found:
			return false

	var src_file: FileAccess = FileAccess.open(src_path, FileAccess.READ)
	if src_file == null:
		return false
	var content: String = src_file.get_as_text()
	src_file.close()

	var dest_file: FileAccess = FileAccess.open(dest_path, FileAccess.WRITE)
	if dest_file == null:
		return false
	dest_file.store_string(content)
	dest_file.close()
	return true

static func _copy_component_dependencies(component_id: StringName) -> void:
	match component_id:
		&"hitbox_component_2d", &"hurtbox_component_2d":
			_ensure_template_copied("DamagePayload.gd")
		&"state_machine":
			_ensure_template_copied("State.gd")
			_ensure_template_copied("PlayerIdleState.gd")
		&"inventory_component":
			_ensure_template_copied("InventorySlot.gd")
			_ensure_template_copied("LootTable.gd")
			_ensure_template_copied("ItemData.gd")
		&"vfx_spawner_component":
			_ensure_template_copied("ImpactVFXPool.gd")

static func _ensure_dir(path: String) -> void:
	if not DirAccess.dir_exists_absolute(path):
		DirAccess.make_dir_recursive_absolute(path)

static func _create_typed_node(node_type: String) -> Node:
	match node_type:
		"Area2D":
			return Area2D.new()
		"Node2D":
			return Node2D.new()
		"Camera2D":
			return Camera2D.new()
		_:
			return Node.new()
