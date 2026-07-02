extends CharacterBody2D

@export var player_speed = 200  # speed in pixels/sec
@export var run_speed = 400
var player_direction: Vector2
@onready var sprite: AnimatedSprite2D = %Sprite

var last_player_dir: Vector2 = Vector2.DOWN

func _physics_process(_delta: float) -> void:
	process_movement()
	process_anim()
	move_and_slide()

#player movement
func process_movement() -> void:
	player_direction = Input.get_vector("move_left", "move_right","move_up","move_down")
	
	#gets called when the player is moving
	if player_direction != Vector2.ZERO:
		velocity = player_direction * player_speed
		last_player_dir = player_direction
	#called when the player is not moving
	else:
		velocity = Vector2.ZERO
	

func process_anim() -> void:
	if velocity != Vector2.ZERO:
		play_animation("walk", last_player_dir)
	else:
		play_animation("idle", last_player_dir)
		

func play_animation(prefix: String, dir: Vector2) -> void:
	if dir.x > 0: 
		sprite.flip_h = false
		sprite.play(prefix + "_side")
		
	if dir.x < 0: 
		sprite.flip_h = true
		sprite.play(prefix + "_side")
		
	elif dir.y < 0: 
		sprite.play(prefix + "_up") 
	elif dir.y > 0: 
		sprite.play(prefix + "_down") 
		
