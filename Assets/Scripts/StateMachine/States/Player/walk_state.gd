extends State

@export_category("States")
@export var idle_state: State
@export var run_state: State

@export_category("variables")
@export var walk_speed := int(200)  # speed in pixels/sec
@onready var sprite: AnimatedSprite2D = %Sprite
@export var player : CharacterBody2D

var player_direction: Vector2
var last_player_dir: Vector2 = Vector2.DOWN






func enter_state() -> void:
	print("walk state")


func update(_detal: float) -> void:
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	player_direction = input_dir
	walk_movement(input_dir)
	
	if Input.is_action_just_pressed("Run"):
		switch_state.emit(run_state)
		exit_state()

func _physics_process(_delta: float) -> void:
	process_anim()
	player.move_and_slide()

func process_anim() -> void:
	if player.velocity != Vector2.ZERO:
		play_animation("walk", last_player_dir)
	else:
		play_animation("idle", last_player_dir)

func walk_movement(input_dir : Vector2):
	if input_dir != Vector2.ZERO:
		player.velocity = player_direction * walk_speed
		last_player_dir = player_direction
	else:
		player.velocity = Vector2.ZERO

func play_animation(prefix: String, dir: Vector2) -> void:
	
	if dir.x > 0: 
		sprite.flip_h = false
		sprite.play(prefix + "_side")
		
	elif dir.x < 0: 
		sprite.flip_h = true
		sprite.play(prefix + "_side")
		
	if abs(dir.y) > abs(dir.x):		#makes y more domanat
		if dir.y < 0:
			sprite.play(prefix + "_up")
		elif dir.y > 0:
			sprite.play(prefix + "_down")
	
