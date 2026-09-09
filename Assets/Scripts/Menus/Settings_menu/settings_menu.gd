extends Control

@onready var video_container: PanelContainer = %Video_container
@onready var audio_container: PanelContainer = %Audio_Container
@onready var controls_container: PanelContainer = %Controls_container

@onready var video_button: Button = %Video_Button
@onready var audio_button: Button = %Audio_Button
@onready var controls_button: Button = %Controls_Button

var windows:Array[PanelContainer] = []

func _ready() -> void:
	pass
	print("hello")
	windows = [
		%Video_container, %Audio_Container, %Controls_container]
	
	video_button.pressed.connect(show_window.bind(windows[0]))
	audio_button.pressed.connect(show_window.bind(windows[1]))
	controls_button.pressed.connect(show_window.bind(windows[2]))
	
	show_window(windows[0])
	video_button.grab_focus()

func show_window(windows_to_show: PanelContainer) -> void:
	@warning_ignore("shadowed_variable")
	for windows in windows:
		windows.hide()
		
	windows_to_show.show()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		pass
