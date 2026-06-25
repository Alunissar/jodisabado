extends Node
class_name Command

var pc_pos:Vector3i
var actions:Array[Action]

func _init(pos:Vector3i, actions:Array[Action]) -> void:
	pc_pos = pos
	self.actions = actions
	for action in actions:
		add_child(action)

func execute():
	for action in actions:
		action.forward()
	pass

func undo():
	for action in actions:
		action.reverse()
	pass
