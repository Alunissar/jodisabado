extends Interactable
class_name InteractableButton

@export var activate : Activatable

@export var is_toggle : bool

var is_on : bool

func interact():
	if is_toggle:
		if is_on:
			activate.activate()
		else:
			activate.deactivate()
		is_on = not is_on
	else:
		activate.activate()
	
	pass
