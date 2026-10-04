extends Button
class_name RemapButton

@export var action: String
@onready var controller_action_label: Label = %Controller_Action_Label
@onready var controller_input_label: Label = %Controller_Input_Label


const CONTROLLER_AXIS_LABELS: Dictionary = {
	JoyAxis.JOY_AXIS_TRIGGER_LEFT: "LT",
	JoyAxis.JOY_AXIS_TRIGGER_RIGHT: "RT",
	JoyAxis.JOY_AXIS_LEFT_X: "LS X",
	JoyAxis.JOY_AXIS_LEFT_Y: "LS Y",
	JoyAxis.JOY_AXIS_RIGHT_X: "RS X",
	JoyAxis.JOY_AXIS_RIGHT_Y: "RS Y",
}

const CONTROLLER_LABELS: Dictionary = {
	JoyButton.JOY_BUTTON_A: "A",
	JoyButton.JOY_BUTTON_B: "B",
	JoyButton.JOY_BUTTON_X: "X",
	JoyButton.JOY_BUTTON_Y: "Y",
	JoyButton.JOY_BUTTON_LEFT_SHOULDER: "LB",
	JoyButton.JOY_BUTTON_RIGHT_SHOULDER: "RB",
	JoyButton.JOY_BUTTON_LEFT_STICK: "L3",
	JoyButton.JOY_BUTTON_RIGHT_STICK: "R3",
	JoyButton.JOY_BUTTON_DPAD_UP: "UP",
	JoyButton.JOY_BUTTON_DPAD_DOWN: "DOWN",
	JoyButton.JOY_BUTTON_DPAD_LEFT: "LEFT",
	JoyButton.JOY_BUTTON_DPAD_RIGHT: "RIGHT",
	JoyButton.JOY_BUTTON_START: "Start",
	JoyButton.JOY_BUTTON_GUIDE: "Select",
	JoyButton.JOY_BUTTON_BACK: "Back",
}

var input_actions:Dictionary = {
	"move_up": "Move Up",
	"move_down": "Move Down",
	"move_left": "Move Left",
	"move_right": "Move Right",
	"interact": "Interact",
	"fullscreen": "Fullscreen",
	"mute_music": "Mute Music"
}



func _init() -> void:
	toggle_mode = false   # a plain pressable button now

func _ready() -> void:
	update_text()
	#controller_action_label.text = action
	controller_action_label.text = input_actions[action]
	
	
	
func update_text() -> void:
	controller_input_label.text = _get_joypad_display(action)

static func _get_joypad_display(action_name: String) -> String:
	for ev in InputMap.action_get_events(action_name):
		if ev is InputEventJoypadButton:
			return CONTROLLER_LABELS.get(ev.button_index, "Btn %d" % ev.button_index)
		if ev is InputEventJoypadMotion:
			var base: String = CONTROLLER_AXIS_LABELS.get(ev.axis, "Axis %d" % ev.axis)
			return base + ("+" if ev.axis_value > 0.0 else "-")
	return "Unbound"

func set_awaiting_input() -> void:
	controller_input_label.text = "press button to bind..."


func set_conflict() -> void:
	controller_input_label.text = "already used! try another"


func set_bound_display(display: String) -> void:
	controller_input_label.text = display
