extends LevelElement
class_name Enemy

@export var base_HP:int
@export var base_ATK:int
@export var base_DEF:int
@export var base_EXP:int

func on_interact() -> void:
	if GameManager.start_combat(self):
		PCInstance.gain_exp(base_EXP)
		collected.emit(self)
		queue_free()
	
	pass
