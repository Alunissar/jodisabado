extends Action
class_name Combat

var _enemy:Enemy

func _init(enemy:Enemy) -> void:
	_enemy = enemy
	

func forward() -> bool:
	printerr("combat command not implemented")
	return false

func reverse() -> bool:
	printerr("combat command not implemented")
	return false
