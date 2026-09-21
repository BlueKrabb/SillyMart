extends CanvasLayer

#Onready

@onready var fps_display_label: Label = %Fps_Display_Label
@onready var display_display_label: Label = %Display_Display_Label



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	fps_display_label.text = str(Engine.get_frames_per_second())
	display_display_label.text = str(get_viewport().get_visible_rect().size)
