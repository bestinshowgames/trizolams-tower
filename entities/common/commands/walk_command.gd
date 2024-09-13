class_name WalkCommand
extends "res://entities/common/commands/command.gd"

class Params:
	var direction: Vector2
	var rate: float
	
	func _init(direction: Vector2, rate: float) -> void:
		self.direction = direction
		self.rate = rate

func execute(actor: Actor, data: Object = null) -> void:
	if data is Params:
		actor.walk(data.direction, data.rate)
