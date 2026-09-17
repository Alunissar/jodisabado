extends Node

var active_camera: Camera3D
var active_controller: CameraController

# Called at game start
func startup() -> void:
	active_camera = Camera3D.new()
	GameManager.worldVP.add_child(active_camera)
	active_camera.position = PCInstance.global_position + Vector3.UP*5
	active_controller = CameraController.new(2, 0)
	add_child(active_controller)
	active_controller.global_position = PCInstance.global_position
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(active_controller != null):
		active_controller.update(active_camera, delta, Vector2.ZERO, 0)
	pass
