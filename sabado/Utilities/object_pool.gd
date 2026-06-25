extends Node

var _pools:Dictionary[String,Array] = {}

func get_object(path:String) -> Node:
	var node:Node3D
	if not _pools.has(path):
		_pools[path] = []
	
	if _pools[path].is_empty():
		node = load(path).instantiate()
		_pools[path].append(node)
	else:
		node = _pools[path].front()
	
	node.show()
	node.set_process(false)
	node.set_process_internal(false)
	
	return node

func return_object(node:Node, path:String):
	
	pass
