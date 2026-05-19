extends Node

const STARTING_LEVEL = preload("uid://bf344f5hvf1ll")

var current_level: Level

func _ready() -> void:
	call_deferred("load_level",STARTING_LEVEL, 0)


func load_level(level: PackedScene, entranceID) -> void:
	
	if current_level != null:
		current_level.queue_free()
	
	var loaded = level.instantiate()
	get_tree().root.add_child(loaded)
	current_level = loaded as Level
	current_level.enter_level(entranceID)
