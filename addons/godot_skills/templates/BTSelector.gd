# res://src/core/components/behavior_tree/bt_selector.gd
class_name BTSelector
extends BTNode
## Composite Selector Node (Logical OR) for Godot 4.x Behavior Trees

var _running_child_index: int = 0

func tick(delta: float) -> Status:
	for i: int in range(_running_child_index, get_child_count()):
		var child: BTNode = get_child(i) as BTNode
		if child == null:
			continue

		var result: Status = child.tick(delta)
		if result == Status.RUNNING:
			_running_child_index = i
			return Status.RUNNING
		elif result == Status.SUCCESS:
			_running_child_index = 0
			return Status.SUCCESS

	_running_child_index = 0
	return Status.FAILURE
