extends Resource
class_name LevelData

@export var itemList: Dictionary[Vector3i, int]
var activeItems: Dictionary[Vector3i, int]
var itemElements: Dictionary[Vector3i, LevelElement]

func setup(level:Level):
	for coord in level.item_map.get_used_cells():
		itemList[coord] = level.item_map.get_cell_item(coord)
	pass

func reset_all():
	activeItems.clear() 
	for item in itemList:
		reset(item)

func reset(pos:Vector3i):
	activeItems[pos] = itemList[pos]

func remove(pos:Vector3i):
	forget(pos)
	activeItems.erase(pos)

func add(pos:Vector3i, id:int):
	activeItems[pos] = id

func forget_all():
	for item in itemElements:
		forget(item)

func forget(pos:Vector3i):
	ObjectPool.return_object(itemElements[pos],LevelElement.id_to_path(activeItems[pos]))
	itemElements.erase(pos)

func remember_all():
	for item in activeItems:
		remember(item)

func remember(pos:Vector3i):
	if(not itemElements.has(pos)):
		itemElements[pos] = ObjectPool.get_object(LevelElement.id_to_path(activeItems[pos]))
		if(!itemElements[pos].get_parent()):
			GameManager.worldVP.add_child(itemElements[pos])
		itemElements[pos].global_position = GameManager.grid_to_world(pos)
