extends Control

@onready var general_button: Button = %General_Button
@onready var audio_button: Button = %Audio_Button
@onready var videp_button: Button = %Videp_Button
@onready var controls_button: Button = %Controls_Button

@onready var header_label: Label = %Header_Label



#vars
var windows: Array [MarginContainer] = []


func _ready() -> void:
	
	print("hello")
	windows = [
		%General_window_MarginContainer, %Audio_window_MarginContainer, %Video_window_MarginContainer, %Controls_window_MarginContainer
	]
	
	general_button.pressed.connect(show_window.bind(windows[0]))
	audio_button.pressed.connect(show_window.bind(windows[1]))
	videp_button.pressed.connect(show_window.bind(windows[2]))
	controls_button.pressed.connect(show_window.bind(windows[3]))
	
	show_window(windows[0])
	general_button.grab_focus()
	header_label.text = "Change gameplay settings"

func show_window(windows_to_show: MarginContainer) -> void:
	#@warning_ignore("shadowed_variable")
	for windows in windows:
		windows.hide()
		
	windows_to_show.show()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


func _on_general_button_pressed() -> void:
	header_label.text = "Change gameplay settings"


func _on_audio_button_pressed() -> void:
	header_label.text = "Change audio values"


func _on_videp_button_pressed() -> void:
	header_label.text = "Change video settings"


func _on_controls_button_pressed() -> void:
	header_label.text = "Change keybinds"
