extends Node
class_name Command

var pc_pos:Vector3i
var actions:Array[Action]

func _init(pos:Vector3i, actions:Array[Action]) -> void:
	pc_pos = pos
	self.actions = actions

func execute():
	for action in actions:
		add_child(action)
		action.forward()
	pass

func undo():
	while actions.size() > 0:
		actions[0].reverse()
		remove_child(actions[0])
		actions[0].queue_free()
	pass
