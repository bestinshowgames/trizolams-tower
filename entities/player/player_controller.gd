class_name PlayerController
extends ActorController

func _physics_process(delta: float) -> void:
	var input = Input.get_vector("left", "right", "up", "down")
	walk_command.execute(actor, WalkCommand.Params.new(input, delta))
