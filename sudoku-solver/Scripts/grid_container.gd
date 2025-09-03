extends GridContainer


@onready var GRID_SIZE = 9
@onready var th = preload("res://Settings/main.tres") as Theme
@onready var lbl = $"../../Label"
@onready var btn = preload("res://Scenes/button.tscn")

@onready var tst_board =   [[0,3,1,0,0,0,0,0,6],      #board on start
						 	[0,4,9,2,0,0,0,3,8],
							[0,2,0,0,1,0,0,4,5],
							[7,5,0,0,0,6,0,0,0],
							[2,0,8,0,0,5,6,0,0],
							[0,9,6,0,3,2,7,5,0],
							[0,6,2,0,7,0,0,0,4],
							[0,0,5,0,0,9,3,0,7],
							[0,7,0,5,6,1,0,2,0]]
							
@onready var btn_board := []
@onready var board := []
@onready var coor := [0,0]
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
		btn_board.append(row)		
		###create buttons in the grid####
	for y in GRID_SIZE:	
		for x in GRID_SIZE: 
			var cell = btn.instantiate() 
			add_child(cell)
			btn_board[y][x] = cell
			#cell.left_click.connect(on_click)
			cell.focused.connect(on_click)
			
	for y in GRID_SIZE:
		for x in GRID_SIZE:
			btn_board[y][x].text = str(tst_board[y][x]) if tst_board[y][x] != 0 else ''
				
func _process(_delta: float) -> void:
	for i in range(10):			#check for key presses
		if Input.is_action_just_pressed(str(i)):
			if i in range(1, 10) && i in main.find_valid(coor):
				update_boards(str(i), [coor[0],coor[1]])
				lbl.text = ''
			elif i == 0:
				update_boards(str(i), [coor[0],coor[1]])
				lbl.text = ''
			else:
				lbl.text = "Invalid number!" 
			
	if Input.is_action_just_pressed("restart"):		
		get_tree().reload_current_scene()
	
		
		
func find_cell(id):
	for y in GRID_SIZE:
		for x in GRID_SIZE:
			if id == btn_board[y][x]:
				return [y,x]
	
func on_click(id):
	var cell = id	#connects to signal that triggers when cell is clicked
	print(cell)
	coor = find_cell(cell)  #find which cell produced the signal		

func update_boards(action, pos):
	
	if action != "0":
		board[pos[0]][pos[1]] = int(action)
		btn_board[pos[0]][pos[1]].text = str(board[pos[0]][pos[1]])
	
	else:
		board[pos[0]][pos[1]] = 0
		btn_board[pos[0]][pos[1]].text = ''
