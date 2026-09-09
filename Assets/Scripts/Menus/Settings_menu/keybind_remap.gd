extends PanelContainer

@onready var input_button_scene = preload("res://Assets/Scenes/UI/Settings_menu/Input_settings/input_button.tscn")
@onready var action_list: VBoxContainer = %ActionList
@onready var reset_keybinds_button: Button = %Reset_Keybinds_Button

var is_remaping = false
var action_to_remap = null
var remaping_button = null

var action_input:Dictionary = {
	"move_up": "Move Up",
	"move_down": "Move Down",
	"move_left": "Move Left",
	"move_right": "Move Right",
	"run": "Run",
	"interact": "Interact"
	
}

func _ready() -> void:
	_create_action_list()
	action_list.add_child(reset_keybinds_button)
	
	
	
func 	_create_action_list():
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
		
	for action in action_input:
		var button = input_button_scene.instantiate()
		var input_label = button.find_child("Input_Label")
		var action_label = button.find_child("Action_Label")
		
		action_label.text = action_input[action]
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			input_label.text = events[0].as_text().trim_suffix("- Physical")
		else:
			input_label.text = ""
		
		action_list.add_child(button)
		button.pressed.connect(_on_Input_buttton_pressed.bind(button, action))
		
func _on_Input_buttton_pressed(button, action):
	#print("_on_Input_buttton_pressed(button, action)")
	if not is_remaping:
		is_remaping = true
		action_to_remap = action
		remaping_button = button
		
		button.find_child("Input_Label").text = "Awaiting Input"
	
func _input(event: InputEvent) -> void:
	if is_remaping and action_to_remap != null:
		if (
			event is InputEventKey ||
			(event is InputEventMouseButton && event.pressed)
		):
			if event is InputEventMouseButton && event.double_click:
				event.double_click = false
			
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			_update_action_list(remaping_button, event)
			
			is_remaping = false
			action_to_remap = null
			remaping_button = null
			accept_event()	
			
func _update_action_list(button, event):
	button.find_child("Input_Label").text = event.as_text().trim_suffix("- Physical")
