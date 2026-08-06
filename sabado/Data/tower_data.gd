extends Resource
class_name TowerData

# Dictionary key is level packedscene path.
var visited_levels: Dictionary[String, LevelData]

func visit_level(level:Level, path:String):
	if not visited_levels.has(path):
		visited_levels[path] = level.data
		
	pass
