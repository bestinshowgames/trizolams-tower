class_name PlayerController
extends ActorController

const COMBO_TIMEOUT = 0.2
const MAX_COMBO_CHAIN = 2

var last_key_delta = 0
var key_combo = []

func _init(_actor: Actor):
	super(_actor)
	run_timer.timeout.connect(_on_run_timer_timeout)
	attack_timer.timeout.connect(_on_attack_timer_timeout)

#region Input Processing
func _input(event) -> void:
	if event is InputEventKey and event.pressed and !event.echo: # If distinct key press down
		if last_key_delta > COMBO_TIMEOUT:                   # Reset combo if stale
			key_combo = []
		
		key_combo.append(event.keycode)                     # Otherwise add it to combo
		if key_combo.size() > MAX_COMBO_CHAIN:               # Prune if necessary
			key_combo.pop_front()
		
		if key_combo.size() == 2 and key_combo[0] == key_combo[1]:
			run_timer.start(0.1)
			walk = false
		last_key_delta = 0

func _physics_process(delta: float) -> void:
	last_key_delta += delta
	_process_movement(delta)
	_process_attack(delta)

func _process_movement(delta: float) -> void:
	var move_direction: Vector2 = Vector2.ZERO
	# subtract opposite input strengths to get net x and y movement
	move_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	move_direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	if !walk:
		dodge_command.execute(actor, DodgeCommand.Params.new(move_direction, delta))
	else:
		walk_command.execute(actor, WalkCommand.Params.new(move_direction, delta))

func _process_attack(_delta: float) -> void:
	var attack = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	if attack and can_attack:
		can_attack = false
		attack_timer.start(0.4) # TODO: Replace with weapon stats attack rate
		attack_command.execute(actor, AttackCommand.Params.new())
#endregion

#region timeouts
func _on_run_timer_timeout():
	walk = true

func _on_attack_timer_timeout():
	can_attack = true
#endregion
