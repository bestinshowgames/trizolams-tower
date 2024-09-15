class_name AttackCommand
extends "res://entities/common/commands/command.gd"

class Params:
	func _init() -> void:
		pass

func execute(actor: Actor, data: Object = null) -> void:
	if data is Params:
		actor.attack()
