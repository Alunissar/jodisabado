extends Node
class_name Command

var pc_pos1:Vector3i
var pc_pos2:Vector3i
var actions:Array[Action]

func _init(pos:Vector3i, actions:Array[Action]) -> void:
	pc_pos1 = pos
	self.actions = actions
	for action in actions:
		add_child(action)

func execute():
	for action in actions:
		action.forward()
	
	pc_pos2 = PCInstance.grid_pos
	pass

func undo():
	for action in actions:
		action.reverse()
	pass
