extends GridContainer


@onready var GRID_SIZE = 9
@onready var th = load("res://Settings/main.tres") as Theme
@onready var lbl = load("res://Scenes/label.tscn") 
@onready var tst_board =   [[0,0,0,0,0,4,8,0,0],      #board to solve
						 	[0,0,3,2,8,0,0,0,5],
							[0,2,0,0,0,6,0,0,0],
							[0,0,5,0,0,0,0,7,0],
							[0,3,0,9,1,0,6,0,0],
							[0,0,0,0,0,2,0,0,0],
							[0,9,0,8,3,0,1,0,0],
							[1,0,0,0,0,0,0,0,6],
							[0,0,0,0,0,0,0,0,0]]
							
@onready var label_board = []				#set up blank board
@onready var board = []
@onready var coor = Vector2()

func _ready() -> void:
					#set up blank board
	for y in GRID_SIZE:
		var row = []
		for x in GRID_SIZE:
			row.append(0)
		board.append(row)
	for y in GRID_SIZE:
		var row = []
		for x in GRID_SIZE:
			row.append(0)
		label_board.append(row)		
		
	for y in GRID_SIZE:	
		for x in GRID_SIZE:
			var cell = lbl.instantiate() 
			add_child(cell)
			label_board[y][x] = cell
			cell.left_click.connect(on_click)
			
	for y in GRID_SIZE:
		for x in GRID_SIZE:
			label_board[y][x].text = str(tst_board[y][x])
				
func _process(delta: float) -> void:
	for i in range(1,10):			#check for key presses
		if Input.is_action_just_pressed(str(i)):
			board[coor[0]][coor[1]] = i
			label_board[coor[0]][coor[1]].text = str(board[coor[0]][coor[1]])
	
func find_cell(id):
	for y in GRID_SIZE:
		for x in GRID_SIZE:
			if id == label_board[y][x]:
				return Vector2(y,x)
	
func on_click(cell):
	coor = find_cell(cell)  #find which cell produced the signal	
	board[coor[0]][coor[1]] = ''	
	label_board[coor[0]][coor[1]].text = str(board[coor[0]][coor[1]]) 
	print ("clicked the cell " + str(int(coor[0])) + str(int(coor[1])))
