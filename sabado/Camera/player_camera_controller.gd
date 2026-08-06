extends CameraController
class_name PlayerCameraController

@export var orbit_distance : float
@export var orbit_height : float
@export var orbit_speed : float

var _wall_distance : float
var _rotation : float
var _raycast : RayCast3D

func _update(camera: Camera3D, delta: float):
	
	var rotatedOffset = Vector3.BACK.rotated(Vector3.UP, _rotation) * (orbit_distance - _wall_distance)
	
	camera.global_position = lerp(camera.global_position, global_position +\
			Vector3(rotatedOffset.x, orbit_height, rotatedOffset.z), easing * delta)
	
	camera.look_at(global_position)
	pass
