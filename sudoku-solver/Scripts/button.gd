extends Button


func _ready() -> void:
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	size_flags_vertical = Control.SIZE_EXPAND_FILL
	alignment = HORIZONTAL_ALIGNMENT_CENTER
	mouse_filter = Control.MOUSE_FILTER_PASS
	
signal focused
func _on_pressed() -> void:
	focused.emit(self)


func _on_focus_entered() -> void:
	focused.emit(self)
