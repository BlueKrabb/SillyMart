extends State

@export_category("States")
@export var walk_state: State
@export var run_state: State

func enter_state() -> void:
	print("idle state")


func update(_detal: float) -> void:
	if Input.get_vector(
		"move_left","move_right","move_up","move_down") != Vector2.ZERO:
			switch_state.emit(walk_state)
			exit_state()
			
	if Input.is_action_just_pressed("Run"):
		switch_state.emit(run_state)
