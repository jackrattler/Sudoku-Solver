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
@onready var coor = []
@onready var main = $"../.."

func _ready() -> void:
					#set up blank board
	for y in GRID_SIZE:
		var row = []
		for x in GRID_SIZE:
			row.append(0)
		board.append(row)
		
	board = tst_board.duplicate()
	
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
			label_board[y][x].text = str(tst_board[y][x]) if tst_board[y][x] != 0 else ''
				
func _process(_delta: float) -> void:
	for i in range(10):			#check for key presses
		if Input.is_action_just_pressed(str(i)):
			if i in range(1, 10) && i in main.find_valid(board, coor):
				update_boards(str(i), [coor[0],coor[1]])
			if i == 0: update_boards(str(i), [coor[0],coor[1]])
			
			
	
		
		
func find_cell(id):
	for y in GRID_SIZE:
		for x in GRID_SIZE:
			if id == label_board[y][x]:
				return [y,x]
	
func on_click(cell):		#connects to signal that triggers when cell is clicked
	coor = find_cell(cell)  #find which cell produced the signal		
	print ("clicked the cell " + str(int(coor[0])) + str(int(coor[1])))

func update_boards(action, pos):
	if action != "0":
		board[pos[0]][pos[1]] = int(action)
		label_board[pos[0]][pos[1]].text = str(board[pos[0]][pos[1]])
	
	else:
		board[pos[0]][pos[1]] = 0
		label_board[pos[0]][pos[1]].text = ''
