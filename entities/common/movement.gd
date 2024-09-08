extends Node

@export var actor: CharacterBody2D
@export var min_slide_angle = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	actor.wall_min_slide_angle = min_slide_angle
	actor.motion_mode = CharacterBody2D.MOTION_MODE_FLOATING

func _physics_process(_delta):
	actor.move_and_slide()
