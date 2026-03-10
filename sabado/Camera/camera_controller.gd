extends Node3D
class_name CameraController

var _camera: SubCamera
@export var easing: float

func resign_camera() -> void:
	_camera = null
	pass

func set_camera(cam: SubCamera) -> void:
	_camera = cam
	pass

func _physics_process(delta: float) -> void:
	if(_camera):
		_update_pos(delta)
		pass
	pass

func _update_pos(delta: float):
	_camera.global_position = lerp(_camera.global_position, global_position, easing);
	pass
