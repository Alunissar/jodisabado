extends Node3D
class_name CameraController

var easing: float = 0.1
var velocity:float
var dist:float
var facing_dir:float

func _init(dist:float, dir:float) -> void:
	velocity = 0
	self.dist = dist
	facing_dir = dir
	pass

func update(camera: Camera3D, delta: float, trans_input:Vector2, rot_input:float) -> void:
	var orb_offset:Vector3 = Vector3(0, dist/2, -dist)
	facing_dir = fmod((facing_dir + rot_input*delta),360)
	
	var target_pos = (position + # original pos
			Vector3(trans_input.x*delta*velocity, 0, trans_input.x*delta*velocity) + # translative input offset
			orb_offset.rotated(Vector3.UP, facing_dir)) # orbiting distance
	
	camera.global_position = lerp(camera.global_position, target_pos, easing);
	camera.look_at(global_position, Vector3.UP)
	pass
