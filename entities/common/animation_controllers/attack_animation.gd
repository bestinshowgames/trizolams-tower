extends Node

@export var actor: CharacterBody2D
@export var sprite: Sprite2D
@export var animation_player: AnimationPlayer

# TODO: With how disjointed animations are, it may be best to have just a singular animation controller
func animate_attack():
	var direction = animation_player.current_animation.left(1)
	animation_player.play("%s_attack" % direction)


func _on_animation_player_animation_finished(anim_name: String):
	if anim_name.contains("attack"):
		var direction = anim_name.left(1)
		var base_anim = "walk" if actor.velocity != Vector2.ZERO else "idle"
		animation_player.play("{dir}_{anim}".format({ 'dir': direction, 'anim': base_anim }))
