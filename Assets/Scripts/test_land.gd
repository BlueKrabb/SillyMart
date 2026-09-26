extends Node2D


@onready var crt: ColorRect = $CanvasLayer/Crt
@onready var pause_scene = preload("res://Assets/Scenes/UI/pause_menu/pause_menu.tscn")
var paused: bool = false



 
func _ready() -> void:
	pass
