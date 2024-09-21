class_name DodgeCommand
extends "res://entities/common/commands/command.gd"

class Params:
	var direction: Vector2
	var rate: float
	
	func _init(_direction: Vector2, _rate: float) -> void:
		self.direction = _direction
		self.rate = _rate

func execute(actor: Actor, data: Object = null) -> void:
	if data is Params:
		actor.dodge(data.direction, data.rate)
