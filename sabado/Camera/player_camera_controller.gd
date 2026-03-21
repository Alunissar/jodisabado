extends CameraController
class_name PlayerCameraController

@export var orbit_distance : float
@export var orbit_height : float
@export var orbit_speed : float

var _wall_distance : float
var _rotation : float
var _raycast : RayCast3D

func set_camera(cam: SubCamera) -> void:
	_camera = cam
	_rotation = global_rotation.y
	_wall_distance = 0
	
	_raycast = RayCast3D.new()
	add_child(_raycast)
	pass

func resign_camera() -> void:
	super()
	_raycast.queue_free()
	pass

func _update_pos(delta: float):
	
	var rotatedOffset = Vector3.BACK.rotated(Vector3.UP, _rotation) * (orbit_distance - _wall_distance)
	
	_camera.global_position = lerp(_camera.global_position, global_position +\
			Vector3(rotatedOffset.x, orbit_height, rotatedOffset.z), easing * delta)
	
	_camera.look_at(global_position)
	pass

func _process(delta: float) -> void:
	# rot input
	if(Input.is_action_pressed("in_rot_right")):
		_rotation = lerp_angle(_rotation, _rotation + orbit_speed * delta, 1)
		pass
	if(Input.is_action_pressed("in_rot_left")):
		_rotation = lerp_angle(_rotation, _rotation - orbit_speed * delta, 1)
		pass

func _physics_process(delta: float) -> void:
	super(delta)
	_raycast.target_position = Vector3.BACK.rotated(Vector3.UP, _rotation) * orbit_distance
	_raycast.target_position.y = orbit_height
	if _raycast.is_colliding():
		_wall_distance = (_raycast.global_position + _raycast.target_position -\
				_raycast.get_collision_point()).length()
		
	else:
		_wall_distance = 0
	pass
