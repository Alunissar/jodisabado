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

var _current_level: Level

var ui_manager: GUIManager

func _ready() -> void:
	var game = GAME_SCENE.instantiate()
	add_child(game)
	worldVP = game.find_child("WorldVP") as Viewport
	
	_state = GameStates.INGAME
	await get_tree().create_timer(0.5).timeout
	call("load_level",STARTING_LEVEL, 0)
	


func load_level(level: PackedScene, entranceID) -> void:
	
	if _current_level != null:
		_current_level.queue_free()
	
	var loaded = level.instantiate()
	worldVP.add_child(loaded)
	_current_level = loaded as Level
	_current_level.enter_level(entranceID)

func grid_to_world(pos:Vector3i) -> Vector3:
	return _current_level.grid_map.map_to_local(pos)

func get_tile_contents(pos:Vector3i):
	return _current_level.get_tile_contents(pos)
