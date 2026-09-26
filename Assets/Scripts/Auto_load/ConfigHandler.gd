extends Node

var config = ConfigFile.new()
const SETTINGS_FILE_PATH = "res://Settings.cfg"


func _ready() -> void:
	if !FileAccess.file_exists(SETTINGS_FILE_PATH):
		config.set_value("video", "window_mode", "Fullscreen")
		config.set_value("video", "crt_effect", true)
		config.set_value("video", "camera_shake", true)
		config.set_value("video", "brightness_value", 50.0)
		
		config.set_value("audio", "master_volume", 80.0)
		config.set_value("audio", "music_volume", 80.0)
		config.set_value("audio", "sfx_volume", 80.0)
		
		config.set_value("keybinds", "move_up", "W")
		config.set_value("keybinds", "move_left", "A")
		config.set_value("keybinds", "move_down", "S")
		config.set_value("keybinds", "move_right", "D")
		config.set_value("keybinds", "interact", "E")
		config.set_value("keybinds", "run", "Shift")
		config.set_value("keybinds", "fullscreen", "F11")
		config.set_value("keybinds", "mute_music", "M")
		
		config.save(SETTINGS_FILE_PATH)
		print("settings SAVED")
	else:
		config.load(SETTINGS_FILE_PATH)

func save_video_settings(key: String, value):
	config.set_value("video", key, value)
	config.save(SETTINGS_FILE_PATH)
	
func load_video_settings():
	var video_settings = {}
	for key in config.get_section_keys("video"):
		video_settings[key] = config.get_value("video", key)
	return video_settings

func save_audio_settings(key: String, value):
	config.set_value("audio", key, value)
	config.save(SETTINGS_FILE_PATH)

func load_audio_settings():
	var audio_settings = {}
	for key in config.get_section_keys("audio"):
		audio_settings[key] = config.get_value("audio", key)
	return audio_settings

func save_keybinds(action: StringName, event: InputEvent):
	var event_str
	if event is InputEventKey:
		event_str = OS.get_keycode_string(event.physical_keycode)
	elif event is InputEventMouseButton:
		event_str = "mouse_" + str(event.button_index)
		
	config.set_value("keybinds", action, event_str)
	config.save(SETTINGS_FILE_PATH)
	
	
func load_keybinds():
	var keybinds = {}
	var keys = config.get_section_keys("keybinds")
	for key in keys:
		var input_event
		var event_str = config.get_value("keybinds", key)
		
		if event_str.contains("mouse_"):
			input_event = InputEventMouseButton.new()
			input_event.button_index = int(event_str.slit("_")[1])
		else:
			input_event = InputEventKey.new()
			input_event.keycode = OS.find_keycode_from_string(event_str)
		
		keybinds[key] = input_event
	return keybinds
	
	
	
	
	
	
	
	
	
