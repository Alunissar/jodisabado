extends Node

func _input(event: InputEvent) -> void:
	if GameManager.get_state() == GameManager.GameStates.INGAME:
		_in_game_input(event)
	pass

func _in_game_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("in_up"):
		PCInstance.move("N")
		pass
	if event.is_action_pressed("in_down"):
		PCInstance.move("S")
		pass
	if event.is_action_pressed("in_left"):
		PCInstance.move("W")
		pass
	if event.is_action_pressed("in_right"):
		PCInstance.move("E")
		pass
	
	if event.is_action_pressed("in_undo"):
		CommandStack.undo()
	
	if event.is_action_pressed("in_redo"):
		CommandStack.redo()
	
	
	pass
