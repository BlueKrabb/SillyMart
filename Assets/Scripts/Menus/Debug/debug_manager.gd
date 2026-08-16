extends CanvasLayer

#Onready

@onready var fps_display_label: Label = %Fps_Display_Label
@onready var monitor_display_label: Label = %Monitor_Display_Label
@onready var display_display_label: Label = %Display_Display_Label

@onready var memory_display_label: Label = %Memory_Display_Label
@onready var cpu_display_label: Label = %Cpu_Display_Label

@onready var gpu_display_label: Label = %Gpu_Display_Label
@onready var cords_display_label: Label = %Cords_Display_Label


# vars


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	fps_display_label.text = str(Engine.get_frames_per_second())
	monitor_display_label.text = str(DebugAPI.get_monitor_info(name))
	
	#display_display_label.text = get_tree().
	
	var used_memory = OS.get_static_memory_usage()
	var memory_info = OS.get_memory_info()
	var total_memory = memory_info["physical"]
	
	var memory_percent = (float(used_memory) / float(total_memory)) * 100
	memory_display_label.text = str(round(memory_percent * 10) / 10) + "%"
	display_display_label.text = str(get_viewport().get_visible_rect().size)
	
func _input(event):
	# Mouse in viewport coordinates.	
	if event is InputEventMouseMotion:
		cords_display_label.text = str(event.position)
