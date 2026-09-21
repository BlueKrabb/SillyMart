extends NinePatchRect

#region On ready
#onready#
@onready var video_button: TextureButton = %Video_Button
@onready var audio_button: TextureButton = %Audio_Button
@onready var controls_button: TextureButton = %Controls_Button

@onready var video_margin_container: MarginContainer = %Video_MarginContainer
@onready var audio_margin_container: MarginContainer = %Audio_MarginContainer
@onready var controls_margin_container: MarginContainer = %Controls_MarginContainer

#scenes
@onready var input_button_scene = preload("res://Assets/Scenes/UI/Settings_menu/Input_settings/input_container.tscn")
@onready var action_list: VBoxContainer = %Input_list_HBoxContainer
#endregion

var windows:Array[MarginContainer] = []
var is_remaping: bool = false
var action_to_remap = null
var remapping_button = null

var input_actions = {
	"move_up": "Move Up",
	"move_down": "Move Down",
	"move_left": "Move Left",
	"move_right": "Move Right",
	"interact": "Interact",
	"fullscreen": "Fullscreen"
}


func _ready() -> void:
	_create_action_list()
#region window
	windows = [
	%Video_MarginContainer, %Audio_MarginContainer, %Controls_MarginContainer]

	video_button.pressed.connect(show_window.bind(windows[0]))
	audio_button.pressed.connect(show_window.bind(windows[1]))
	controls_button.pressed.connect(show_window.bind(windows[2]))
	
	show_window(windows[0])
	video_button.grab_focus()
#endregion


func show_window(windows_to_show: MarginContainer) -> void:
	@warning_ignore("shadowed_variable")
	for windows in windows:
		windows.hide()
	windows_to_show.show()

func _create_action_list():
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
		
	for action in input_actions:
		var button = input_button_scene.instantiate()
		var action_label = button.find_child("Action_Label")
		var input_label = button.find_child("Input_Label")
		
		action_label.text = input_actions[action]
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			input_label.text = events[0].as_text().trim_suffix(" - Physical")
		else:
			input_label.text = ""
		
		action_list.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button, action))

func _on_input_button_pressed(button, action):
	if !is_remaping:
		is_remaping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("Input_Label").text = "press key to bind..."
		
		
func _input(event: InputEvent) -> void:
	if is_remaping and action_to_remap != null:
		if (
			event is InputEventKey ||
			(event is InputEventMouseButton && event.pressed)
		):
		#prevent two action to have the same input
			for action in input_actions:
				if action == action_to_remap:
					continue

				if InputMap.action_has_event(action, event):
					print("key in use :", action)
					remapping_button.find_child("Input_Label").text = "already used!"
					is_remaping = false
					action_to_remap = null
					remapping_button = null
					accept_event()
					return
					
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			_update_action_list(remapping_button, event)
			
			is_remaping = false
			action_to_remap = null
			remapping_button = null
			accept_event()	
			
func _update_action_list(button, event):
	button.find_child("Input_Label").text = event.as_text().trim_suffix("- Physical")
