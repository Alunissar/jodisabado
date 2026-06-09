extends Resource
class_name LevelData

@export var itemList: Dictionary[Vector3i, int]
var itemCollected: Dictionary[Vector3i, bool]

func setup(level:Level):
	for coord in level.item_map.get_used_cells():
		itemList[coord] = level.item_map.get_cell_item(coord)
	pass

func clear_collected():
	itemCollected.clear() 
	for item in itemList:
		itemCollected[item] = false
