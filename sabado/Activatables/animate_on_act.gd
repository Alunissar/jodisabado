extends Activatable

@export
var animator : AnimationPlayer

func _ready() -> void:
	if(animator == null):
		animator = find_child("AnimationPlayer") as AnimationPlayer
		pass
	pass

func activate():
	animator.play("Activate")
	
	pass

func deactivate():
	animator.play("Deactivate")
	
	pass
