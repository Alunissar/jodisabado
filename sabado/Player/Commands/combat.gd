extends Action
class_name Combat

var _enemy:Enemy

static func calc_combat_results(enemy:Enemy) -> Variant:
	if PCInstance.ATK < enemy.get_def(): return null
	var turn_count:int = ceil(enemy.get_hp() / (PCInstance.ATK-enemy.get_def()))
	var damage_taken:int = (enemy.get_atk()-PCInstance.DEF)*turn_count
	var TRT:int = ceil(float(enemy.get_hp())/(turn_count-1)-PCInstance.ATK+enemy.get_def())
	print (damage_taken, " damage taken in ", turn_count-1, " turns. TRT: ", TRT)
	return {turns = turn_count, damage = damage_taken, TRT = TRT}

func _init(enemy:Enemy) -> void:
	_enemy = enemy
	

func forward() -> bool:
	var calc = calc_combat_results(_enemy)
	
	print(calc)
	
	var hp = _enemy.get_hp()
	
	while PCInstance.ATK > _enemy.get_def():
		
		hp -= (PCInstance.ATK-_enemy.get_def())
		if hp<=0:
			PCInstance.gain_exp(_enemy.base_EXP)
			_enemy.collected.emit(_enemy)
			_enemy.queue_free()
			return true;
			
		PCInstance.gain_health(-max(_enemy.get_atk() - PCInstance.DEF,0))
		if PCInstance.HP <= 0:
			return true;
	
	return false

func reverse() -> bool:
	printerr("combat command not implemented")
	return false
