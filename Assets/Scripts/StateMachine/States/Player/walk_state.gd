extends State

@export_category("States")
@export var idle_state: State
@export var sprint_state: State 

@export_category("player")
@export var walk_speed = int(100)  # speed in pixels/sec


@onready var sprite: AnimatedSprite2D = %Sprite
@export var player : CharacterBody2D
var player_direction: Vector2
var last_player_dir: Vector2 = Vector2.DOWN
var current_anim: String = ""
var anim_name: String



func enter_state() -> void:
	#make animation speed 1.0
	sprite.speed_scale = 1.0


func _physics_process(_delta: float) -> void:
	update(_delta)
	process_anim()
	player.move_and_slide()

func update(_detal: float) -> void:

	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	player_direction = input_dir
	walk_movement(input_dir)
	
#-----animtions-------------
func process_anim() -> void:
	if player.velocity != Vector2.ZERO:
			play_animation("walk", last_player_dir)
	else:
		#code will save the last player direction and play the idle animtion to fit it
		play_animation("idle", last_player_dir)		
		
func play_animation(prefix: String, dir: Vector2) -> void:

	if abs(dir.x) >= abs(dir.y):
		if dir.x > 0: 
			sprite.flip_h = false	#not flip player sprite if the player is facing right
			anim_name = prefix + "_side"
		elif dir.x < 0: 
			sprite.flip_h = true	#flip player sprite if the player is facing right
			anim_name = prefix + "_side"	#play animation that has side on it's name
		
	else:
		if dir.y < 0:
			anim_name = prefix + "_up"
		elif dir.y > 0:
			anim_name = prefix + "_down"

	if current_anim != anim_name:	#if the currect animation does not match the aniamtion name
		current_anim = anim_name	#currect animation is the same as animation name
		sprite.play(anim_name)
	else:
		sprite.play(anim_name)

#--------player walk movement----------
func walk_movement(input_dir : Vector2):	#this will be called when the player is walking
	#gets called when the player is walking
	if player_direction != Vector2.ZERO:	#if the player is walking do this
		
		if Input.is_action_pressed("sprint"):	#if the player is moving and the player presses spint key it will call this
			switch_state.emit(sprint_state)
			exit_state()
			
		player.velocity = player_direction * walk_speed
		last_player_dir = player_direction
	
	else:
		#called when the player is not moving
		player.velocity = Vector2.ZERO
		switch_state.emit(idle_state)	#swith to the idle state
		exit_state()	
		
