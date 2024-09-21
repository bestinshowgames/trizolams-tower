class_name ActorController
extends Node

var actor: Actor

var run_timer: Timer
var attack_timer: Timer
var walk = true
var can_attack = true

var walk_command := WalkCommand.new()
var dodge_command := DodgeCommand.new()
var attack_command := AttackCommand.new()

func _init(_actor: Actor) -> void:
	self.actor = _actor
	run_timer = Timer.new()
	attack_timer = Timer.new()
	add_child(run_timer)
	add_child(attack_timer)
