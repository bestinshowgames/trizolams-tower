extends Node

@export var actor: CharacterBody2D
@export var sprite: Sprite2D
@export var animation_player: AnimationPlayer

var current_animation: String
var previous_direction: Vector2

func _ready():
	animation_player.play("d_idle")
	current_animation = "d_idle"
	previous_direction = actor.velocity

func animate_walk(direction: Vector2):
	if direction != previous_direction:
		previous_direction = direction
		var next_anim
		
		if direction == Vector2.ZERO && !animation_player.current_animation.ends_with("idle"):
			next_anim = _get_idle_animation()
		else:
			next_anim = _get_walk_animation(direction)
			if direction.x >= 0:
				sprite.flip_h = false
			else:
				sprite.flip_h = true
				
		animation_player.play(next_anim)
		current_animation = next_anim

func _get_idle_animation() -> String:
	return "%s_idle" % current_animation.left(1)

func _get_walk_animation(direction: Vector2) -> String:
	var next_anim_dir: String
	var curr_anim_dir = current_animation.left(1)
	
	if direction.x == 0:
		next_anim_dir = "u" if direction.y < 0 else "d"
	elif direction.y == 0:
		next_anim_dir = "h"
	else:
		if curr_anim_dir in ["u", "d"]:
			next_anim_dir = "h"
		else:
			next_anim_dir = "u" if direction.y < 0 else "d"
	
	return "%s_walk" % next_anim_dir
