extends Node
class_name Level

@onready var grid_map: GridMap = $GridMap
@onready var item_map: GridMap = $ItemMap
@export var entrances: Dictionary[Variant, Vector3i]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func enter_level(entranceID) -> void:
	if entrances.has(entranceID):
		PCInstance.move_to(entrances[entranceID])
	pass

func get_tile_contents(pos: Vector3i):
	match grid_map.get_cell_item(pos):
		1: return { "type"="wall" }
		
		2: 
			var cont = {"type" = "stairs"}
			match grid_map.get_cell_item_orientation(pos):
				0:cont["direction"] = "E"
				16:cont["direction"] = "N"
				10: cont["direction"] = "W"
				22:cont["direction"] = "S"
			return cont
		
		3: 
			var cont = {"type" = "cliff"}
			match grid_map.get_cell_item_orientation(pos):
				0:cont["direction"] = "E"
				16:cont["direction"] = "N"
				10: cont["direction"] = "W"
				22:cont["direction"] = "S"
			return cont
		
		0: 
			if item_map.get_cell_item(pos) == -1: return {"type" = "ground"}
			else: return {"type" = "item",
						  "ID" = item_map.get_cell_item(pos)}
		
		-1: 
			return { "type"="air" }
	
	push_error("FAILED READING TILE CONTENTS")
	return false
