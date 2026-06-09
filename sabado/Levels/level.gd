@tool
extends Node
class_name Level

@onready var grid_map: GridMap = $GridMap
@onready var item_map: GridMap = $ItemMap
@export var entrances: Dictionary[String, Vector3i]

var data: LevelData
var item_refs: Dictionary[Vector3i, LevelElement]
var entered_from:String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint(): return;
	data = ResourceLoader.load("res://Levels/Data/" + name + "_data.tres")
	pass # Replace with function body.

func enter_level(entranceID) -> void:
	if Engine.is_editor_hint(): return;
	
	if entrances.has(entranceID):
		entered_from = entranceID
		PCInstance.move_to(entrances[entranceID])
	
	pass

func get_tile_contents(pos: Vector3i):
	if Engine.is_editor_hint(): return;
	
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
			if item_refs.has(pos): return {"type" = "item"}
			else: return {"type" = "ground"}
		
		-1: 
			return { "type"="air" }
	
	push_error("FAILED READING TILE CONTENTS")
	return false

func load_items() -> void:
	if Engine.is_editor_hint(): return;
	
	if item_map != null:
		item_map.queue_free()
	
	for item in data.itemList:
		var item_obj = LevelElement.id_to_packed_scene(data.itemList[item]).instantiate() as LevelElement
		item_obj.position = grid_map.to_global(grid_map.map_to_local(item))
		item_refs[item] = item_obj
		item_obj.collected.connect(forget_item)
		
		add_child(item_obj)
		pass
	
	pass

func forget_item(item:LevelElement) -> void:
	var pos = item_refs.find_key(item)
	item_refs.erase(pos)

@export_tool_button("Bake Level Data")
var button = _bake_level_data

func _bake_level_data() -> void:
	print("baking level data")
	
	data = LevelData.new()
	data.setup(self)
	if ResourceSaver.save(data, "res://Levels/Data/" + name + "_data.tres") == 0:
		print("successful write")
	else: print("failed write")
	
	print(data.itemList)
	
	pass
