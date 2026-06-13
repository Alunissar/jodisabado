extends Action
class_name AddStat

var _exp:int
var _hp:int
var _atk:int
var _def:int

func _init(exp:int, hp:int, atk:int, def:int) -> void:
	_exp = exp
	_hp = hp
	_atk = atk
	_def = def
	pass

func forward():
	PCInstance.gain_exp(_exp)
	PCInstance.gain_health(_hp)
	PCInstance.gain_atk(_atk)
	PCInstance.gain_def(_def)
	pass

func reverse():
	PCInstance.gain_exp(-_exp)
	PCInstance.gain_health(-_hp)
	PCInstance.gain_atk(-_atk)
	PCInstance.gain_def(-_def)
	pass
