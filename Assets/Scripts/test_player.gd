extends CharacterBody2D



var sprint_speed = 500
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var player_direction: Vector2

func _physics_process(_delta: float) -> void:
	move_and_slide()
	#print(player.global_position)


func walk_movement(input_dir : Vector2):
	if input_dir != Vector2.ZERO:
		velocity = player_direction *SPEED
	
		if Input.is_action_just_pressed("sprint"):
				velocity  = player_direction * sprint_speed
