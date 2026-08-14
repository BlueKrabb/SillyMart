extends Control


@onready var Header_Label: Label = %Header_Label
@onready var general_button: Button = %General_Button
@onready var audio_button: Button = %Audio_Button
@onready var videp_button: Button = %Videp_Button
@onready var controls_button: Button = %Controls_Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_general_button_pressed() -> void:
	Header_Label.text = "Change game general settings"

func _on_audio_button_pressed() -> void:
	Header_Label.text = "Change game audio settings"

func _on_videp_button_pressed() -> void:
	Header_Label.text = "Change game video settings"

func _on_controls_button_pressed() -> void:
	Header_Label.text = "Change game keybinds"
