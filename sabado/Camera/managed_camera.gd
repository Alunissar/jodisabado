extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	make_current()
	CameraManager.active_camera = self
	pass # Replace with function body.
