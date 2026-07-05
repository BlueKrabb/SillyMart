extends CharacterBody2D

@export var player_speed = 200  # speed in pixels/sec
@export var run_speed = 400
var player_direction: Vector2
@onready var sprite: AnimatedSprite2D = %Sprite

var last_player_dir: Vector2 = Vector2.DOWN
