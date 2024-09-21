class_name AnimationController
extends Node

@export var actor: CharacterBody2D
@export var sprite: Sprite2D
@export var animation_player: AnimationPlayer

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
var state: String = "idle"

func _ready():
	animation_player.play(anim_direction() + "_idle")
	
func moved(move_direction: Vector2) -> void:
	if set_direction(move_direction) || set_state(move_direction):
		update_animation()
	
func set_direction(_direction: Vector2) -> bool:
	var new_direction: Vector2 = cardinal_direction
	if _direction == Vector2.ZERO:
		return false
	
	if _direction.y == 0:
		new_direction = Vector2.LEFT if _direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_direction = Vector2.UP if _direction.y < 0 else Vector2.DOWN
		
	if new_direction == cardinal_direction:
		return false
	
	cardinal_direction = new_direction
	# scale the x of the sprite instead of flip h so that any other sub-sprites also flip
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

func set_state(_direction: Vector2) -> bool:
	var new_state: String = "idle" if _direction == Vector2.ZERO else "walk"
	if new_state == state:
		return false
	state = new_state
	return true

func update_animation() -> void:
	animation_player.play(anim_direction() + "_" + state)

func anim_direction() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "d"
	elif cardinal_direction == Vector2.UP:
		return "u"
	else:
		return "h"
