extends Node
var arrow = preload("res://Assets/Sprites/Ui/Cursor/arrow.png")

var fullscreen: bool = false

func _ready() -> void:
	Input.set_custom_mouse_cursor(arrow) 

func _process(_delta: float) -> void:
		Input.set_custom_mouse_cursor(arrow, Input.CURSOR_ARROW)
		#Input.set_custom_mouse_cursor(beam, Input.CURSOR_IBEAM)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("fullscreen"):
		fullscreen = not fullscreen
		toggle_fullscreen()
		
	if event.is_action_pressed("ui_cancel"):
		_quiting_game()


func _quiting_game():
	if !Input.is_action_pressed("ui_cancel"):
		return
	await get_tree().create_timer(1.5).timeout
	if !Input.is_action_pressed("ui_cancel"):
		return
	print("closing gane....")
	get_tree().quit()

func toggle_fullscreen():
	if fullscreen:
		print("window mode is now fullscren")
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		print("window mode is now windowed")
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		DisplayServer.window_set_size(Vector2i(800, 600))
