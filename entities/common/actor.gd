class_name Actor
extends CharacterBody2D

@export var movement_stats: MovementStats

func walk(_direction: Vector2, _rate: float) -> void:
	pass

func dodge(_direction: Vector2, _rate: float) -> void:
	pass

func attack() -> void:
	pass
