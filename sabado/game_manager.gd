extends Node

const STARTING_LEVEL = preload("uid://bf344f5hvf1ll")

enum GameStates {
	MENU,
	PAUSED,
	INGAME,
}
var _state: GameStates
func get_state() -> GameStates:
	return _state

var _current_level: Level

func _ready() -> void:
	call_deferred("load_level",STARTING_LEVEL, 0)
	_state = GameStates.INGAME
	
	var strin = "NSEWUP"
	print(strin, " || ", Global.invert_dir(strin))


func load_level(level: PackedScene, entranceID) -> void:
	
	if _current_level != null:
		_current_level.queue_free()
	
	var loaded = level.instantiate()
	get_tree().root.add_child(loaded)
	_current_level = loaded as Level
	_current_level.enter_level(entranceID)

func grid_to_world(pos:Vector3i) -> Vector3:
	return _current_level.grid_map.map_to_local(pos)

func get_tile_contents(pos:Vector3i):
	return _current_level.get_tile_contents(pos)
