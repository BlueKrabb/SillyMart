extends Camera2D
var camera: Camera2D  = self

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_CTRL):
		camera.zoom  = Vector2(5.0, 5.0) 
	else:
		camera.zoom  = Vector2(1.0, 1.0)
