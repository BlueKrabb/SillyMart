extends AnimatedSprite2D
const SHADOWS = preload("uid://dh8p3dyly88yt")
@onready var player_sprite: AnimatedSprite2D = %Sprite
var shadow_sprite = self



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Copy everything from player to shadow
	shadow_sprite.animation = player_sprite.animation
	shadow_sprite.frame = player_sprite.frame
	shadow_sprite.flip_h = player_sprite.flip_h
