extends Node3D
class_name CameraController

@export var easing: float

func _update(camera: Camera3D, delta: float):
	camera.global_position = lerp(camera.global_position, global_position, easing);
	pass
