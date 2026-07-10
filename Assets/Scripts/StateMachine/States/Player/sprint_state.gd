extends State

@export_category("States")
@export var idle_state: State
@export var walk_state: State 

@export_category("player")
@export var sprint_speed := int(200)	# speed in pixels/sec


@onready var sprite: AnimatedSprite2D = %Sprite
@export var player : CharacterBody2D

var player_direction: Vector2
var last_player_dir: Vector2 = Vector2.DOWN
var current_anim: String = ""
var anim_name: String


func enter_state() -> void:
	sprite.speed_scale = 2.0	#make animations faster when in sprint state
	print("sprint state entered")	#print in the console that sprint state is entered
	#i'm using this for debuging


func update(_detal: float) -> void:
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	player_direction = input_dir
	sprint_movement(input_dir)
	

func _physics_process(_delta: float) -> void:
	update(_delta)
	process_anim()
	player.move_and_slide()

func process_anim() -> void:

	if player.velocity != Vector2.ZERO:
			play_animation("walk", last_player_dir)
	else:
		sprite.speed_scale = 1.0
		play_animation("idle", last_player_dir)

func play_animation(prefix: String, dir: Vector2) -> void:

	if abs(dir.x) >= abs(dir.y):
		if dir.x > 0: 
			sprite.flip_h = false
			anim_name = prefix + "_side"
		elif dir.x < 0: 
			sprite.flip_h = true
			anim_name = prefix + "_side"
		
	else:
		if dir.y < 0:
			anim_name = prefix + "_up"
		elif dir.y > 0:
			anim_name = prefix + "_down"

	if current_anim != anim_name:
		current_anim = anim_name
		sprite.play(anim_name)
	else:
		sprite.play(anim_name)

func sprint_movement(input_dir : Vector2):
	if input_dir != Vector2.ZERO:
		
		if not Input.is_action_pressed("sprint"):
			switch_state.emit(walk_state)
			current_anim = ""
			exit_state()

		player.velocity = player_direction * sprint_speed
		last_player_dir = player_direction
	
	else:
		player.velocity = Vector2.ZERO
		switch_state.emit(idle_state)
		exit_state()
