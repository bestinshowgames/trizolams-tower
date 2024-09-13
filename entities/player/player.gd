extends Actor

@export var movement_stats: MovementStats

signal moved(direction: Vector2)

var _controller: ActorController

func _ready() -> void:
	set_controller(PlayerController.new(self))
	
func set_controller(controller: ActorController) -> void:
	for child in $ControllerContainer.get_children():
		child.queue_free()
		
	_controller = controller
	$ControllerContainer.add_child(_controller)
	
func walk(direction: Vector2, rate: float) -> void:
	if direction.length() > 0:
		velocity = velocity.move_toward(direction * movement_stats.max_speed, movement_stats.acceleration * rate)
		moved.emit(direction)
	elif velocity != Vector2.ZERO:
		velocity = Vector2.ZERO
		moved.emit(direction)
	move_and_slide()
