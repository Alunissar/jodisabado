extends Resource
class_name TowerData

var visited_levels: Array[Level]

func visit_level(level: Level):
	if not visited_levels.has(level):
		visited_levels.append(level)
		
	pass
