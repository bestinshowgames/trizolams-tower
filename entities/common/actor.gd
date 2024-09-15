class_name Actor
extends CharacterBody2D

@export var movement_stats: MovementStats

func walk(direction: Vector2, rate: float) -> void:
	pass

func dodge(direction: Vector2, rate: float) -> void:
	pass

func attack() -> void:
	pass
