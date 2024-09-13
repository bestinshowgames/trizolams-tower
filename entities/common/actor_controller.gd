class_name ActorController
extends Node

var actor: Actor

var walk_command := WalkCommand.new()

func _init(actor: Actor) -> void:
	self.actor = actor
