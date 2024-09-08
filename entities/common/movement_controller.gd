extends Node

@export var actor: CharacterBody2D
@export var movement_stats: MovementStats

signal movement_changed(dir: Vector2)

var previous_direction: Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	previous_direction = Vector2.ZERO

func process_movement(direction: Vector2, rate: float):
	if direction.length() > 0:
		actor.velocity = actor.velocity.move_toward(direction * movement_stats.max_speed, movement_stats.acceleration * rate)
	elif actor.velocity != Vector2.ZERO:
		actor.velocity = Vector2.ZERO
		
	if direction != previous_direction:
		previous_direction = direction
		movement_changed.emit(direction)
