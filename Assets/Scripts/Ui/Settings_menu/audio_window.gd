extends MarginContainer

@onready var master_h_slider: HSlider = %Master_HSlider
@onready var music_h_slider: HSlider = %Music_HSlider
@onready var sfx_h_slider: HSlider = %Sfx_HSlider

@onready var master_volume_value_label: Label = %Master_volume_Value_Label
@onready var music_volume_value_label: Label = %Music_volume_Value_Label
@onready var sfx_volume_value_label: Label = %sfx_volume_Value_Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	master_volume_value_label.text = str(int(master_h_slider.value)) + "%"
	music_volume_value_label.text = str(int(music_h_slider.value)) + "%"
	sfx_volume_value_label.text = str(int(sfx_h_slider.value)) + "%"

func _on_master_h_slider_value_changed(value: float) -> void:
	master_volume_value_label.text = str(int(master_h_slider.value)) + "%"
	print("master volume is:" ,master_h_slider.value,str("%"))


func _on_music_h_slider_value_changed(value: float) -> void:
		music_volume_value_label.text = str(int(music_h_slider.value)) + "%"
		print("music volume is:" ,music_h_slider.value,str("%"))

func _on_sfx_h_slider_value_changed(value: float) -> void:
	sfx_volume_value_label.text = str(int(sfx_h_slider.value)) + "%"
	print("sfx volume is:" ,music_h_slider.value,str("%"))
