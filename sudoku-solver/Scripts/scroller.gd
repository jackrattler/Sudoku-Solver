extends VScrollBar


@onready var nms = load("res://Settings/label_no_mouse.tres")
@onready var ms = load("res://Settings/label_mouse.tres")



func _on_value_changed(value: float) -> void:
	var val = 1 + (value / 100)
	nms.font_size = 20 * val
	ms.font_size = 24 * val
