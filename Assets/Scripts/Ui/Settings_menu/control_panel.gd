extends NinePatchRect

#region On ready
#onready#
@onready var video_button: TextureButton = %Video_Button
@onready var audio_button: TextureButton = %Audio_Button
@onready var controls_button: TextureButton = %Controls_Button

#video settings
@onready var crt_button: CheckButton = %Crt_Button
@onready var camera_shake_button: CheckButton = %Camera_shake_Button
@onready var brightness_value_slider: HSlider = %Brightness_slider
@onready var fullscreen_mode_button: Button = %Fullscreen_mode_button

#audio settings
@onready var master_volume_slider: HSlider = %Master_Slider
@onready var music_volume_slider: HSlider = %Music_Slider
@onready var sfx_volume_slider: HSlider = %Sfx_slider

@onready var video_label: Label = %Video_Label
@onready var audio_label: Label = %Audio_Label
@onready var controls_label: Label = %Controls_Label


@onready var video_margin_container: MarginContainer = %Video_MarginContainer
@onready var audio_margin_container: MarginContainer = %Audio_MarginContainer
@onready var controls_margin_container: MarginContainer = %Controls_MarginContainer

#scenes
@onready var input_button_scene = preload("res://Assets/Scenes/UI/Settings_menu/Input_settings/input_container.tscn")
@onready var reset_button_scene = preload("res://Assets/Scenes/UI/Settings_menu/Input_settings/reset_keybinds_button.tscn")

@onready var action_list: VBoxContainer = %Input_list_HBoxContainer
var fullscreen_modes:Array[String] = ["Fullscreen", "Windowed", "Borderless"]
var fullscreen_index:int = 0
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
	"fullscreen": "Fullscreen",
	"mute_music": "Mute Music"
}


func _ready() -> void:
	
	var video_settings= ConfigHandler.load_video_settings()
	fullscreen_mode_button.button_pressed = (video_settings.get("window_mode", "Fullscreen") == "Fullscreen")
	crt_button.button_pressed = video_settings.get("crt_effects", true)
	camera_shake_button.button_pressed = video_settings.get("crt_effects", true)
	brightness_value_slider.value = video_settings.get("brightness_value", 80.0)
	
	var audio_settings = ConfigHandler.load_audio_settings()
	master_volume_slider.value = audio_settings.get("master_volume", 80.0) 
	music_volume_slider.value = audio_settings.get("music_volume", 80.0) 
	sfx_volume_slider.value = audio_settings.get("sfx_volume", 81.0)
	
	
	_create_action_list()
	fullscreen_mode_button.text = fullscreen_modes[fullscreen_index]
	
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
		#var reset_keybind_button = reset_button_scene.instantiate()
		
		action_label.text = input_actions[action]
		
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			input_label.text = events[0].as_text().trim_suffix(" - Physical")
		else:
			input_label.text = ""
		
		action_list.add_child(button)
		#action_list.add_child(reset_keybind_button)
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


#region Change text color
func _on_video_button_focus_entered() -> void:
	video_label.add_theme_color_override("font_color", Color("23427eff"))


func _on_video_button_focus_exited() -> void:
	video_label.add_theme_color_override("font_color", Color("000000ff"))


func _on_audio_button_focus_entered() -> void:
	audio_label.add_theme_color_override("font_color", Color("23427eff"))


func _on_audio_button_focus_exited() -> void:
	audio_label.add_theme_color_override("font_color", Color("000000ff"))


func _on_controls_button_focus_entered() -> void:
	controls_label.add_theme_color_override("font_color", Color("23427eff"))


func _on_controls_button_focus_exited() -> void:
	controls_label.add_theme_color_override("font_color", Color("000000ff"))
#endregion


func _on_fullscreen_mode_button_pressed() -> void:
	fullscreen_index = (fullscreen_index + 1) % fullscreen_modes.size()
	fullscreen_mode_button.text = fullscreen_modes[fullscreen_index]
	_apply_fullscreen_mode(fullscreen_modes[fullscreen_index])
	ConfigHandler.save_video_settings("window_mode", fullscreen_modes[fullscreen_index])
	
@warning_ignore("shadowed_variable")
func _apply_fullscreen_mode(fullscreen_modes: String) -> void:
	
	match fullscreen_modes:
			"Fullscreen":
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
				DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			
			"Windowed":
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
				DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
				DisplayServer.window_set_size(Vector2i(800, 600))
			
			"Borderless":
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
				DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)

#region Save settings
#save settings
func _on_crt_button_toggled(toggled_on: bool) -> void:
	ConfigHandler.save_video_settings("crt_effect", toggled_on)

func _on_camera_shake_button_toggled(toggled_on: bool) -> void:
	ConfigHandler.save_video_settings("camera_shake", toggled_on)


func _on_master_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigHandler.save_audio_settings("master_volume", master_volume_slider.value)


func _on_music_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigHandler.save_audio_settings("music_volume", music_volume_slider.value)


func _on_sfx_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigHandler.save_audio_settings("sfx_volume", sfx_volume_slider.value)

func _on_brightness_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		ConfigHandler.save_video_settings("brightness_value", brightness_value_slider.value)

#endregion
