extends Node

func make_command(actions:Array[Action]):
	
	var command = Command.new(PCInstance.position, actions)
	add_child(command)
	command.execute()
	

func undo():
	var command = get_child(0) as Command
	
	command.undo()
	command.queue_free()
