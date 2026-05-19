extends Node3D
class_name PlayerCharacter

# Const references
const PLAYER_MESH = preload("uid://bep42vfydxyvk")

# Component references
var mesh : Node3D

# State variables
var grid_pos: Vector3i

func _enter_tree() -> void:
	mesh = PLAYER_MESH.instantiate()
	add_child(mesh)
	pass

func move_to(pos: Vector3i) -> void:
	var tile_contents = GameManager.current_level.get_tile_contents(pos)
	print("move to ", pos, " || tile type = [", tile_contents["type"], "]")
	match tile_contents["type"]:
		"ground":
			grid_pos = pos
			global_position = GameManager.current_level.grid_map.map_to_local(grid_pos)
