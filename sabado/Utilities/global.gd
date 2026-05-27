extends Node

const _N : int = 78
const _S : int = 83
const _E : int = 69
const _W : int = 87
const _D : int = 68
const _U : int = 85

func invert_dir(dir:String) -> String:
	# que pepino...
	dir = dir.replace_char(_N, 46)
	dir = dir.replace_char(_S, _N)
	dir = dir.replace_char(46, _S)
	
	dir = dir.replace_char(_E, 46)
	dir = dir.replace_char(_W, _E)
	dir = dir.replace_char(46, _W)
	
	dir = dir.replace_char(_U, 46)
	dir = dir.replace_char(_D, _U)
	dir = dir.replace_char(46, _D)
	
	return dir

func dir_to_Vector(dir:String) -> Vector3i:
	var vec = Vector3i.ZERO
	
	for i in dir.length():
		match dir[i]:
			"N": vec += Vector3i.FORWARD
			"S": vec += Vector3i.BACK
			"E": vec += Vector3i.RIGHT
			"W": vec += Vector3i.LEFT
			"D": vec += Vector3i.DOWN
			"U": vec += Vector3i.UP
	
	return vec

func insert_group_splitters(value:String, splitter:String = ".", group_size:int = 3):
	
	var temp = value
	
	value = temp.left(temp.length()%group_size)
	temp = temp.trim_prefix(value)
	
	for i in temp.length()/group_size:
		value += splitter
		
		value += temp.left(group_size)
		temp = temp.trim_prefix(temp.left(group_size))
	
	value = value.trim_prefix(splitter)
	return value
