extends Camera3D
class_name SubCamera

@export var _controller : CameraController

func _ready() -> void:
	_controller._camera = self
	pass

func set_controller(contr : CameraController) -> void:
	_controller.resign_camera()
	_controller = contr
	pass
