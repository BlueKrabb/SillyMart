extends State

@export_category("States")
@export var walk_state: State
@export var idle_state: State



func enter_state() -> void:
	print("run state")
	
func exit_state() -> void:
	pass
	
func update(_detal: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
