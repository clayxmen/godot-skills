# res://src/core/components/goap/goap_planner.gd
class_name GOAPPlanner
extends RefCounted
## High-Performance A* Action Graph Search Planner for Godot 4.x

func plan(actor: Node, available_actions: Array[GOAPAction], world_state: Dictionary, desired_state: Dictionary) -> Array[GOAPAction]:
	var usable_actions: Array[GOAPAction] = []
	for action: GOAPAction in available_actions:
		if action.is_valid(actor, world_state):
			usable_actions.append(action)

	var leaves: Array[PlanNode] = []
	var start_node: PlanNode = PlanNode.new(null, 0.0, world_state, null)

	var success: bool = _build_graph(start_node, leaves, usable_actions, desired_state)
	if not success or leaves.is_empty():
		return []

	var cheapest: PlanNode = leaves[0]
	for leaf: PlanNode in leaves:
		if leaf.running_cost < cheapest.running_cost:
			cheapest = leaf

	var result_plan: Array[GOAPAction] = []
	var curr: PlanNode = cheapest
	while curr != null:
		if curr.action != null:
			result_plan.push_front(curr.action)
		curr = curr.parent

	return result_plan

func _build_graph(parent: PlanNode, leaves: Array[PlanNode], actions: Array[GOAPAction], desired: Dictionary) -> bool:
	var found_path: bool = false

	for action: GOAPAction in actions:
		if _matches_conditions(action.preconditions, parent.state):
			var current_state: Dictionary = parent.state.duplicate()
			for key in action.effects:
				current_state[key] = action.effects[key]

			var node: PlanNode = PlanNode.new(parent, parent.running_cost + action.cost, current_state, action)

			if _matches_conditions(desired, current_state):
				leaves.append(node)
				found_path = true
			else:
				var subset: Array[GOAPAction] = actions.duplicate()
				subset.erase(action)
				var sub_found: bool = _build_graph(node, leaves, subset, desired)
				if sub_found:
					found_path = true

	return found_path

func _matches_conditions(conditions: Dictionary, state: Dictionary) -> bool:
	for key in conditions:
		if not state.has(key) or state[key] != conditions[key]:
			return false
	return true

class PlanNode extends RefCounted:
	var parent: PlanNode
	var running_cost: float
	var state: Dictionary
	var action: GOAPAction

	func _init(p_parent: PlanNode, p_cost: float, p_state: Dictionary, p_action: GOAPAction) -> void:
		parent = p_parent
		running_cost = p_cost
		state = p_state
		action = p_action
