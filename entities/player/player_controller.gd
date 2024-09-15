class_name PlayerController
extends ActorController

const COMBO_TIMEOUT = 0.2
const MAX_COMBO_CHAIN = 2

var last_key_delta = 0
var key_combo = []

func _init(actor: Actor):
	super(actor)
	run_timer.timeout.connect(_on_run_timer_timeout)
	attack_timer.timeout.connect(_on_attack_timer_timeout)

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
	elif event is InputEventMouseButton and can_attack and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		can_attack = false
		attack_timer.start(0.3) # TODO: Replace with weapon stats attack rate
		attack_command.execute(actor, AttackCommand.Params.new())

func _physics_process(delta: float) -> void:
	last_key_delta += delta
	var input = Input.get_vector("left", "right", "up", "down")
	if !walk:
		dodge_command.execute(actor, DodgeCommand.Params.new(input, delta))
	else:
		walk_command.execute(actor, WalkCommand.Params.new(input, delta))

func _on_run_timer_timeout():
	walk = true

func _on_attack_timer_timeout():
	can_attack = true
