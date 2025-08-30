extends Label

@onready var mouse_in := false
signal left_click 

func _ready() -> void:
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	size_flags_vertical = Control.SIZE_EXPAND_FILL
	vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	mouse_filter = Control.MOUSE_FILTER_STOP
	
	text = '0'
	
func _on_mouse_entered() -> void:
	label_settings = load("res://Settings/label_mouse.tres") 
	mouse_in = true

func _on_mouse_exited() -> void:
	label_settings = load("res://Settings/label_no_mouse.tres")
	mouse_in = false
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("l_click") && mouse_in:
		text = ''
		left_click.emit(left_click.get_object())

	
