extends CameraController
class_name PlayerCameraController

@export var orbit_distance : float
@export var orbit_height : float

var _direction : Vector2

var _rotation : float

func set_camera(cam: SubCamera) -> void:
	_camera = cam
	_direction = Vector2(_camera.global_basis.z.x, _camera.global_basis.z.z) * orbit_distance
	pass

func _update_pos(delta: float):
	_camera.global_position = lerp(_camera.global_position, global_position +\
			Vector3(_direction.x, orbit_height, _direction.y), easing)
	
	_camera.look_at(global_position)
	pass
