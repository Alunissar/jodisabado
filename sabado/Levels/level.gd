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
		
		2: return {"type" = "stairs",
				   "direction" = grid_map.get_cell_item_orientation(pos)}
		
		3: return {"type" = "cliff",
				   "direction" = grid_map.get_cell_item_orientation(pos)}
		
		0: 
			if item_map.get_cell_item(pos) == -1: return {"type" = "ground"}
			else: return {"type" = "item",
						  "ID" = item_map.get_cell_item(pos)}
		
		-1: 
			printerr("PLAYER TRIED MOVING OUT OF BOUNDS")
			return { "type"="wall" }
	
	printerr("FAILED READING TILE CONTENTS")
	return false
