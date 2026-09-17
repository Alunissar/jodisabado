extends Node

var active_camera: Camera3D
var active_controller: CameraController
var rot_input: float
var trans_input: Vector2

# Called at game start
func startup() -> void:
	active_camera = Camera3D.new()
	GameManager.worldVP.add_child(active_camera)
	active_camera.position = PCInstance.global_position + Vector3.UP*5
	active_controller = CameraController.new(5, 180)
	add_child(active_controller)
	active_controller.global_position = PCInstance.global_position
	
	rot_input = 0
	trans_input = Vector2.ZERO
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(active_controller != null):
		active_controller.global_position = lerp(active_controller.global_position,PCInstance.global_position,0.05)
		active_controller.update(active_camera, delta, trans_input, rot_input)
		trans_input = Vector2.ZERO
		rot_input = 0
	pass

func rotate_input(input:float) -> void:
	rot_input += input
	
