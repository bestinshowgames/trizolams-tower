extends Node

@export var actor: CharacterBody2D
@export var sprite: Sprite2D
@export var animation_player: AnimationPlayer

var current_animation: String

func _ready():
	animation_player.play("d_idle")
	current_animation = "d_idle"

func _process(_delta):
	pass

func animate_movement(dir: Vector2):
	if dir == Vector2.ZERO && !animation_player.current_animation.ends_with("idle"):
		var anim_name = "%s_idle" % current_animation.left(1)
		animation_player.play(anim_name)
		current_animation = anim_name
	else:
		var next_anim_dir: String
		var curr_anim_dir = current_animation.left(1)
		
		if dir.x == 0:
			next_anim_dir = "u" if dir.y < 0 else "d"
		elif dir.y == 0:
			next_anim_dir = "h"
		else:
			if curr_anim_dir in ["u", "d"]:
				next_anim_dir = "h"
			else:
				next_anim_dir = "u" if dir.y < 0 else "d"
		
		if dir.x >= 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
		
		var next_anim = "%s_walk" % next_anim_dir
		animation_player.play(next_anim)
		current_animation = next_anim
