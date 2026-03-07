extends CameraController
class_name PlayerCameraController

@export var orbit_distance : float
@export var orbit_height : float
var _direction

var _rotation : float

func _update_pos(delta: float):
	#_camera.global_position = global_position 
	pass
