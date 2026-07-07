extends State

@export_category("States")
@export var walk_state: State
@export var sprint_state: State

func enter_state() -> void:
	print("entred idle state")


func update(_detal: float) -> void:
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
			
	if input_dir != Vector2.ZERO:
		switch_state.emit(walk_state)
		exit_state()
	
