extends Node3D
class_name CameraController

var _camera: SubCamera
@export var easing: float

func resign_camera() -> void:
	_camera = null
	pass

func set_camera(cam: SubCamera) -> void:
	_camera = cam
	_camera.set_controller(self)
	pass

func _process(delta: float) -> void:
	_update_pos(delta)
	pass

func _update_pos(delta: float):
	_camera.global_position = lerp(_camera.global_position, global_position, easing);
	pass
