extends Node

const STARTING_LEVEL = preload("uid://bf344f5hvf1ll")
const GAME_SCENE = preload("uid://b6jjrybyvvgqm")

enum GameStates {
	MENU,
	PAUSED,
	INGAME,
}
var _state: GameStates
func get_state() -> GameStates:
	return _state

var worldVP: Viewport
var ui_manager: GUIManager

var _current_level: Level

var tower_data: TowerData

func _ready() -> void:
	var game = GAME_SCENE.instantiate()
	add_child(game)
	worldVP = game.find_child("WorldVP") as Viewport
	
	await get_tree().create_timer(0.1).timeout
	
	start_game()
	pass

func start_game() -> void:
	tower_data = TowerData.new()
	_state = GameStates.INGAME
	
	call("load_level",STARTING_LEVEL, "")
	
	PCInstance.HP = 200
	PCInstance.ATK = 5
	PCInstance.DEF = 0
	PCInstance.LVL = 1
	PCInstance.EXP = 0
	
	CommandStack.make_command([AddStat.new(0,100,2,2)])
	
	ui_manager.update_all()
	pass

func load_level(level: PackedScene, entranceID) -> void:
	if _current_level != null:
		_current_level.queue_free()
	
	var loaded = level.instantiate()
	_current_level = loaded as Level
	
	worldVP.add_child(loaded)
	tower_data.visit_level(_current_level)
	_current_level.load_items()
	_current_level.enter_level(entranceID)
	
	pass

func grid_to_world(pos:Vector3i) -> Vector3:
	return _current_level.grid_map.map_to_local(pos)

func get_tile_contents(pos:Vector3i):
	return _current_level.get_tile_contents(pos)

func interact_with(pos:Vector3i):
	_current_level.item_refs[pos].on_interact()
	pass
