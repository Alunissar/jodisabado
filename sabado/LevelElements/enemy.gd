extends LevelElement
class_name Enemy

@export var base_HP:int
@export var base_ATK:int
@export var base_DEF:int
@export var base_EXP:int

func get_hp() ->int:
	return base_HP

func get_atk()->int:
	return base_ATK

func get_def()->int:
	return base_DEF

func get_exp()->int:
	return base_EXP

func on_interact() -> void:
	CommandStack.make_command([Combat.new(self),AddStat.new(0,0,1,0)])
	pass
