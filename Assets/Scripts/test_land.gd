extends Node2D

@onready var pause_menu: Control = %Pause_menu
@onready var crt: ColorRect = $CanvasLayer/Crt
@onready var settings_menu: Control = %Settings_menu

@onready var resume_button: Button = $CanvasLayer/Pause_menu/PanelContainer/CenterContainer/VBoxContainer/Resume_Button
@onready var settings_button: Button = $CanvasLayer/Pause_menu/PanelContainer/CenterContainer/VBoxContainer/Settings_Button
@onready var exit_button: Button = $CanvasLayer/Pause_menu/PanelContainer/CenterContainer/VBoxContainer/Exit_Button

var paused: bool = false

func _ready() -> void:
	resume_button.pressed.connect(resume_game)
	exit_button.pressed.connect(quit_game)
	settings_button.pressed.connect(show_settings)
	settings_menu.hide()
	


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		pause_menu.show()
	
	if settings_menu.is_visible_in_tree():
		pause_menu.hide()
		
	
func resume_game():
	pause_menu.hide()

func quit_game():
	get_tree().quit()
	
func show_settings():
	settings_menu.show()
