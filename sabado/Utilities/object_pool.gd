extends Node

var _pools:Dictionary[String,Array] = {}

func get_object(path:String) -> Node:
	var node:Node3D
	if not _pools.has(path):
		_pools[path] = []
	
	if _pools[path].is_empty():
		node = load(path).instantiate()
	else:
		node = _pools[path].pop_front()
	
	node.show()
	node.set_process(true)
	node.set_process_internal(true)
	
	return node

func return_object(node:Node3D, path:String):
	if not _pools.has(path):
		_pools[path] = []
	
	node.hide()
	node.set_process(false)
	node.set_process_internal(false)
	
	_pools[path].append(node)
	
	pass
