extends Action
class_name Combat

var _enemy:Enemy
var _enemy_id:int
var _enemy_pos:Vector3i
var calc:Variant

static func damage_step_value(enemy:Enemy) -> int:
	return max(enemy.get_atk() - PCInstance.DEF, 0)

static func attack_step_value(enemy:Enemy) -> int:
	return max(PCInstance.ATK - enemy.get_def(), 0)

static func calc_combat_results(enemy:Enemy) -> Variant:
	var atk_stp:int = attack_step_value(enemy)
	if(atk_stp <= 0): return false
	var dmg_stp:int = damage_step_value(enemy)
	
	var turn_count:int = (enemy.get_hp()+atk_stp-1) / atk_stp
	var damage_taken:int = (dmg_stp)*turn_count
	var TRT:int = (enemy.get_hp()+turn_count-2)/(turn_count-1)-PCInstance.ATK+enemy.get_def()
	
	print (damage_taken, " damage taken in ", turn_count-1, " turns. TRT: ", TRT)
	return {turns = turn_count, damage = damage_taken, TRT = TRT}

func _init(pos:Vector3i) -> void:
	_enemy = GameManager.current_level.item_refs[pos] as Enemy
	_enemy_id = GameManager.current_level.data.itemList[pos]
	

func forward() -> bool:
	calc = calc_combat_results(_enemy)
	
	print(calc)
	
	var hp = _enemy.get_hp()
	
	while PCInstance.ATK > _enemy.get_def():
		
		hp -= (PCInstance.ATK-_enemy.get_def())
		if hp<=0:
			PCInstance.gain_exp(_enemy.base_EXP)
			_enemy.collected.emit(_enemy)
			ObjectPool.return_object(_enemy, LevelElement.id_to_path(_enemy.element_id))
			return true;
			
		PCInstance.gain_health(-max(_enemy.get_atk() - PCInstance.DEF,0))
		if PCInstance.HP <= 0:
			return true;
	
	return false

func reverse() -> bool:
	PCInstance.gain_health(calc["damage"])
	calc = []
	
	var enmy = ObjectPool.get_object(LevelElement.id_to_path(_enemy_id))
	GameManager.current_level.add_child(enmy)
	
	return true
