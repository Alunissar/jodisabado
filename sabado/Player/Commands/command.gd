extends Node
class_name Command

var pc_pos1:Vector3i
var pc_pos2:Vector3i
var _actions:Array[Action]

func _init(pos:Vector3i, actions:Array[Action]) -> void:
	pc_pos1 = pos
	_actions = actions
	for action in actions:
		add_child(action)

func execute():
	for action in _actions:
		action.forward()
	
	pc_pos2 = PCInstance.grid_pos
	pass

func redo():
	for action in _actions:
		action.forward()
	
	PCInstance.grid_pos = pc_pos2
	PCInstance.global_position = GameManager.grid_to_world(pc_pos2) + Vector3.DOWN
	pass

func undo():
	for action in _actions:
		action.reverse()
	
	PCInstance.grid_pos = pc_pos1
	PCInstance.global_position = GameManager.grid_to_world(pc_pos1) + Vector3.DOWN
	pass
