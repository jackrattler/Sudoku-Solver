extends Control

@onready var grid = get_node("AspectRatioContainer/GridContainer")
@onready var button = get_node("Button")

@onready var board = []
@onready var valids_board = []

func _ready() -> void:
	####initialise board####
	for y in grid.GRID_SIZE:
		var row = []
		for x in grid.GRID_SIZE:
			row.append(0)
		board.append(row)
	######valids board#####	
	for y in grid.GRID_SIZE:
		var row = []
		for x in grid.GRID_SIZE:
			row.append(0)
		valids_board.append(row)		
			
		

func _on_button_pressed() -> void:
	####when 'Solve' button is pressed
	board = grid.board.duplicate()
	solve()


func solve():
	while true:
		if simple_solve():
			break
		if find_uniques():			#need to fix function- 
			break
		if brute():
			break
		else:	
			$Label2.text = 'not happenin'
			break
	update_board()
	
		
	
	
func find_empty():                       #find all empty cells
	var empties = []
	for i in range (9):
		for j in range (9):
			if board[i][j] == 0:        		#if empty, 
				empties.append([i,j])       #add to the list

	if empties: return empties 
	else: return false                #if no cells are empty, return false	

func simple_solve():

	while find_empty():
		var empty_cells = find_empty()                          #find all empty cells 
		for i in empty_cells:                               #and loop through them
			var valids = find_valid(board, i)               #find what numbers are valid for that cell   
			valids_board[i[0]][i[1]] = valids if valids is not bool else []          #store all valids to valids_board
			if valids_board[i[0]][i[1]] == []:			#if nothing valid at an empty cell
				
				return false
			if len(valids) == 1:                            #if only 1 valid number
				board[i[0]][i[1]] = valids[0]           #insert that number to the board
				valids_board[i[0]][i[1]] = 0                #remove any digits from the corresponding valids_board cell
				simple_solve()

			if len(valids) > 1 and i == empty_cells[-1]:      #if we exhaust the empties and still can't solve
				return false                                #get outta here      
	return true                                             #no more empties- puzzle solved

func brute():
	
	var empties = find_empty()
	if not empties: return true                                 #no empties- puzzle solved

	var pos = empties[0]                                            #take first empty

	for x in valids_board[pos[0]][pos[1]]:                      #loop through the valids at first position
		board[pos[0]][pos[1]] = x    
		var valids = find_valid(board, pos)                       #put valid (x) in there   
		if x in valids:                                     #if board still valid, 
			if brute():                                     #recurse
				return true
			
	board[pos[0]][pos[1]] = 0                           #change it back to zero if board now invalid

	return false


	
	
func find_uniques():    #prob need to figure out how to do the set arithmetic!!!!!!!
	if not find_empty(): return true      #no empties means the puzzle has been solved

	for i in range(9):
		for j in range(9):
			if valids_board[i][j]:                      #loop through valids_board searching for unsolved cells
				var pos = [i,j]                                   
				var exclusive = valids_board[pos[0]][pos[1]].duplicate(true)
				
				for a in valids_board[pos[0]][pos[1]]:
					for x in range(9):
						if is_instance_of(valids_board[pos[0]][x], TYPE_ARRAY) and a in valids_board[pos[0]][x] and not [pos[0], x] == pos:
							exclusive.erase(a)
						if is_instance_of(valids_board[x][pos[1]], TYPE_ARRAY) and a in valids_board[x][pos[1]] and not [x, pos[1]] == pos:
							exclusive.erase(a)
						
					for x in range (int(i/3), int(i/3) * 3 + 3):            #3x3 grid check
						for y in range(int(j/3), int(j/3)* 3 + 3 ):
							if is_instance_of(valids_board[x][y], TYPE_ARRAY) and a in valids_board[x][y] and not [x,y] == (pos):
								exclusive.erase(a)
								
				'''for x in range(9):
					if valids_board[i][x] and not [i,x] == (pos):        #if not the current cell and not a solved cell
						exclusive = exclusive.append(valids_board[i][x])   #add all valids to exclusive array  
				for y in range(9):
					if valids_board[y][j] and not [y,j] == (pos):
						exclusive = exclusive.append(valids_board[y][j])

				for x in range (int(i/3), int(i/3) * 3 + 3):            #3x3 grid check
					for y in range(int(j/3), int(j/3)* 3 + 3 ):
						if valids_board[x][y] and not [x,y] == (pos):
							exclusive = exclusive - valids_board[x][y]'''
					
				#if a digit is only valid for this cell within its row, column or 3x3 grid
				#pop it in the board and remove the valids 
				if len(exclusive) == 1:                                 
					board[pos[0]][pos[1]] = exclusive[0]
					valids_board[pos[0]][pos[1]] = 0
					find_uniques()               #if a cells solution has been found start again until no cell solutions are found

func find_valid(board, pos):         #find all valid digits at pos
	var valids := Array(range(1,10))                             

	for i in range(9):                                      
			#check within the cells row ignoring current pos and remove invalid 
		if board[i][pos[1]] in valids and not (pos == [i,pos[1]]):  
			valids.erase(board[i][pos[1]])
			#check against column
		if board[pos[0]][i] in valids and not (pos == [pos[0],i]):
			valids.erase(board[pos[0]][i])

				#check against 3x3 cell
	for i in range(int(pos[0]/3)*3, int(pos[0]/3)*3 +3):      
		for j in range (int(pos[1]/3)*3, int(pos[1]/3)*3+3):
			if board[i][j] in valids and not [pos[0], pos[1]] == [i, j]:
				valids.erase(board[i][j])

	return Array(valids)

func update_board():
	for y in 9:
		for x in 9:
			grid.label_board[y][x].text = str(board [y][x])
