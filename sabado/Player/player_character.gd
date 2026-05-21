extends Node3D
class_name PlayerCharacter

# Const references
const PLAYER_MESH = preload("uid://bep42vfydxyvk")

# Component references
var mesh : Node3D

# State variables
var grid_pos: Vector3i
var facing_dir: String

func _enter_tree() -> void:
	mesh = PLAYER_MESH.instantiate()
	add_child(mesh)
	pass


func _ready() -> void:
		facing_dir = "N"

func move(dir):
	match dir:
		"E":
			facing_dir = "E"
			move_to(grid_pos + Vector3i(1,0,0))
			pass
		"N":
			facing_dir = "N"
			move_to(grid_pos + Vector3i(0,0,-1))
			pass
		"W":
			facing_dir = "W"
			move_to(grid_pos + Vector3i(-1,0,0))
			pass
		"S":
			facing_dir = "S"
			move_to(grid_pos + Vector3i(0,0,1))
			pass
		"D":
			facing_dir += "D"
			move_to(grid_pos + Vector3i(0,-1,0))
			pass
		
	pass

func move_to(pos: Vector3i) -> void:
	var tile_contents = GameManager.get_tile_contents(pos)
	print("move to ", pos, " || tile type = [", tile_contents["type"], "] || facing dir = [", facing_dir, "]")
	match tile_contents["type"]:
		
		"ground":
			grid_pos = pos
			global_position = GameManager.grid_to_world(pos) + Vector3.DOWN
		
		"stairs":
			if facing_dir.contains("D"):
				print("going down")
				move(Global.invert_dir(tile_contents["direction"]))
			else: 
				print("going up")
				
				if facing_dir == tile_contents["direction"]:
					move_to(pos + Vector3i.UP + Global.dir_to_Vector(tile_contents["direction"]))
					pass
		
		"air":
			grid_pos = pos
			global_position = GameManager.grid_to_world(pos) + Vector3.DOWN
			move("D")
		
	if(tile_contents.has("direction")):
		print("tile direction = [", tile_contents["direction"], "]")
