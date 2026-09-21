extends NinePatchRect

var dragging:bool = false
var offset = Vector2(0,0)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if dragging:
		position = get_global_mouse_position() - offset


func _on_button_button_down() -> void:
	dragging = true
	offset = get_global_mouse_position() - global_position


func _on_button_button_up() -> void:
	dragging = false
