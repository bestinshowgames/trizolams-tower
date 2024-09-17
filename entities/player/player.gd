extends Actor

signal moved(direction: Vector2)
signal attacked

var _controller: ActorController

func _ready() -> void:
	set_controller(PlayerController.new(self))
	
func set_controller(controller: ActorController) -> void:
	for child in $ControllerContainer.get_children():
		child.queue_free()
		
	_controller = controller
	$ControllerContainer.add_child(_controller)
	
func walk(direction: Vector2, rate: float) -> void:
	_move(direction, 
		direction * movement_stats.max_speed, 
		movement_stats.acceleration * rate
	)

func dodge(direction: Vector2, rate: float) -> void:
	_move(direction, 
		direction * movement_stats.max_speed * movement_stats.dodge_factor, 
		movement_stats.acceleration * rate * movement_stats.dodge_factor
	)
	
func attack() -> void:
	attacked.emit()

func _move(direction: Vector2, to: Vector2, delta: float):
	if direction.length() > 0:
		# TODO: Add a mechanism for halting current motion before moving 
		# toward new direction
		velocity = velocity.move_toward(to, delta)
		moved.emit(direction)
	elif velocity != Vector2.ZERO:
		velocity = Vector2.ZERO
		moved.emit(direction)
	move_and_slide()
