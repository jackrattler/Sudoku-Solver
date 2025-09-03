extends VSlider

@onready var bs = preload("res://Settings/btn_def.tres")


func _on_value_changed(value: float) -> void:
	var val = 1 + (value / 100)
	bs.default_font_size = int(20 * val)
	bs.default_font_size = int(24 * val)
