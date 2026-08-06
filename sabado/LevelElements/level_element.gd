extends Node3D
class_name LevelElement

signal collected
var id

func on_interact(pos:Vector3i) -> void:
	collected.emit(self)
	queue_free()

static func id_to_packed_scene(id:int) -> PackedScene:
	return load(id_to_path(id))

static func id_to_path(id:int) -> String:
	match id:
		0:
			return "res://LevelElements/Scenes/enemy_harpy.tscn"
	
	return "INVALID ID"
