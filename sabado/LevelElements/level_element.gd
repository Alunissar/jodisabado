extends Node3D
class_name LevelElement

signal collected

func on_interact() -> void:
	collected.emit(self)
	queue_free()

static func id_to_packed_scene(id:int) -> PackedScene:
	var path
	
	match id:
		0:
			path = "res://LevelElements/Scenes/enemy_harpy.tscn"
			pass
	
	return load(path)
