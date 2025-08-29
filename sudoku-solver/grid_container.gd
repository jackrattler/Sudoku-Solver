extends GridContainer

@onready var GRID_SIZE = 9
@onready var th = load("res://main.tres") as Theme

func _ready() -> void:
	var board = []				#set up blank board
	for y in GRID_SIZE:
		var row = []
		for x in GRID_SIZE:
			row.append(0)
		board.append(row)	
		
	for y in GRID_SIZE:	
		for x in GRID_SIZE:
			var cell = Label.new()
			add_child(cell)
			cell.text = '0'
			cell.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			cell.size_flags_vertical = Control.SIZE_EXPAND_FILL
			cell.vertical_alignment = 1
			cell.horizontal_alignment = 1
			cell.mouse_filter = Control.MOUSE_FILTER_STOP
			
func _process(delta: float) -> void:
	pass		
		
	


func _on_mouse_entered() -> void:
	print("mouse entered")
	th.clear_color("font_color", "Label")
