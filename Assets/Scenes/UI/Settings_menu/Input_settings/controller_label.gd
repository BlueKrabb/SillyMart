extends Node
class_name ControllerLabels



const MAP:Dictionary = {
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
	JoyButton.JOY_BUTTON_START:"Start",
	JoyButton.JOY_BUTTON_GUIDE:"Select"
}



static func button_to_text(button_index: int) -> String:
	return MAP.get(button_index, "JoyButton %d" %button_index)
