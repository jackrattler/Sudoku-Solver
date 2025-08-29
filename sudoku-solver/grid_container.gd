extends GridContainer

var GRID_SIZE = 9
@export var CELL_SIZE = size.x / GRID_SIZE


func _ready() -> void:
	var board = []				#set up blank board
	for y in GRID_SIZE:
		var row = []
		for x in GRID_SIZE:
			row.append(0)
		board.append(row)	
		
	for y in GRID_SIZE:	
		for x in GRID_SIZE:
			var cell = Button.new()
			cell.position = Vector2(y*CELL_SIZE, x*CELL_SIZE)
			cell. = Color(255,255,255,255)
			
		
		
	
