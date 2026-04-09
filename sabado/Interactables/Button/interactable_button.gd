extends Interactable
class_name InteractableButton

@export var activate : Activatable

@export var toggle : bool

var _isOn : bool


func interact():
	activate.activate()
	pass
