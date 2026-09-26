extends Button

@onready var action_label: Label = %Action_Label
@onready var input_label: Label = %Input_Label



func _ready() -> void:
	input_label.add_theme_color_override("font_color", Color("000000ff"))
	action_label.add_theme_color_override("font_color", Color("000000ff"))


func _on_pressed() -> void:
	input_label.add_theme_color_override("font_color", Color("23427eff"))
	action_label.add_theme_color_override("font_color", Color("23427eff"))
	


func _on_focus_entered() -> void:
	input_label.add_theme_color_override("font_color", Color("23427eff"))
	action_label.add_theme_color_override("font_color", Color("23427eff"))


func _on_focus_exited() -> void:
	input_label.add_theme_color_override("font_color", Color("000000ff"))
	action_label.add_theme_color_override("font_color", Color("000000ff"))
