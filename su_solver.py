import time

tst_board = [[0,0,0,0,0,4,8,0,0],      #board to solve
             [0,0,3,2,8,0,0,0,5],
             [0,2,0,0,0,6,0,0,0],
             [0,0,5,0,0,0,0,7,0],
             [0,3,0,9,1,0,6,0,0],
             [0,0,0,0,0,2,0,0,0],
             [0,9,0,8,3,0,1,0,0],
             [1,0,0,0,0,0,0,0,6],
             [0,0,0,0,0,0,0,0,0]]


         #initialise board to hold valid digits
valids_board = [[0 for i in range(9)] for j in range(9)]                             


def display_board(board):
    for i in range (9):                     #loop through row
        if i == 3 or i == 6:
                print ("-- -- -- -- -- -- -- -- -- -- -")                   
        for j in range (9):                  #loop through column
            if j == 3 or j == 6:
                print ("| ", board[i][j], end = '  ')
            else:
                print (board[i][j], end ='  ')
            if j == 8:
                print ("\n", end = '')

def find_empty():                       #find all empty cells
    empties = []
    for i in range (9):
        for j in range (9):
            if tst_board[i][j] == 0:        #if empty, 
                empties.append((i,j))       #add to the list

    if empties: return empties 

    else: return False                #if no cells are empty, return false


def find_valid(board, pos):         #find all valid digits at pos
    valids = list(range(1,10))                             

    for i in range(9):                                      
        for j in range (9):
                #check within the cells row ignoring current pos and remove invalid 
            if board[i][pos[1]] in valids and not (pos == (i,pos[1])):  
                valids.remove(board[i][pos[1]])
                #check against column
            if board[pos[0]][j] in valids and not (pos == (pos[0],j)):
                valids.remove(board[pos[0]][j]) 

                #check against 3x3 cell
    for i in range(int(pos[0]/3)*3, int(pos[0]/3)*3 +3):      
        for j in range (int(pos[1]/3)*3, int(pos[1]/3)*3+3):
            if board[i][j] in valids and not (pos[0], pos[1]) == (i, j):
                valids.remove(board[i][j])

    return valids

def find_uniques():
    if not find_empty(): return True        #no empties means the puzzle has been solved

    for i in range(9):
        for j in range(9):
            if not valids_board[i][j] == 0:                      #loop through valids_board searching for unsolved cells
                pos = i,j                                   
                exclusive = set(valids_board[pos[0]][pos[1]])
                for x in range(9):
                    if valids_board[i][x] and not (i,x) == (pos):        #if not the current cell and not a solved cell
                        exclusive = exclusive - set(valids_board[i][x])  #subtract the valids from our current cells valids  
                for y in range(9):
                    if valids_board[y][j] and not (y,j) == (pos):
                        exclusive = exclusive - set(valids_board[y][j])

                for x in range (int(i/3), int(i/3) * 3 + 3):            #3x3 grid check
                    for y in range(int(j/3), int(j/3)* 3 + 3 ):
                        if valids_board[x][y] and not (x,y) == (pos):
                            exclusive = exclusive - set(valids_board[x][y])
                    
                #if a digit is only valid for this cell within its row, column or 3x3 grid
                #pop it in the board and remove the valids 
                if len(exclusive) == 1:                                 
                    tst_board[pos[0]][pos[1]] = list(exclusive)[0]
                    valids_board[pos[0]][pos[1]] = 0
                    return find_uniques()               #if a cells solution has been found start again until no cell solutions are found

                    


def brute():
    empties = find_empty()
    if not empties: return True                                 #no empties- puzzle solved

    pos = empties[0]                                            #take first empty

    for x in valids_board[pos[0]][pos[1]]:                      #loop through the valids at first position
        tst_board[pos[0]][pos[1]] = x    
        valids = find_valid(tst_board, pos)                       #put valid (x) in there   
        if x in valids:                                     #if board still valid, 
            if brute():                                     #recurse
                return True
            
    tst_board[pos[0]][pos[1]] = 0                           #change it back to zero if board now invalid

        


    return False
                    
                            

    

def simple_solve():
    

    while find_empty():
        empty_cells = find_empty()                          #find all empty cells 
        for i in empty_cells:                               #and loop through them
            valids = find_valid(tst_board, i)               #find what numbers are valid for that cell   
            valids_board[i[0]][i[1]] = valids               #store all valids to valids_board

            if len(valids) == 1:                            #if only 1 valid number
                tst_board[i[0]][i[1]] = valids[0]           #insert that number to the board
                valids_board[i[0]][i[1]] = 0                #remove any digits from the corresponding valids_board cell
                continue

            if len(valids) > 1 and i == empty_cells[-1]:      #if we exhaust the empties and still can't solve
                return False                                #get outta here

        #####find rows, columns or 3x3s where a digit is only valid for 1 element        
        #valids_board = find_uniques(valids_board)           
        
        
    return True                                             #no more empties- puzzle solved
        
        
        




#########start of program###########
print("\n\nUnsolved board")
display_board(tst_board)
print("\n\n")
input("Press Enter to solve")  
start_time = time.time()           #start timer

if simple_solve():
    display_board(tst_board)
    print("\nSolved using the simple solve method")

if find_uniques():
    display_board(tst_board)
    print("\nSolved using 'find uniques' method")

if brute():
    display_board(tst_board)
    print("\nSolved using brute force method")

    finish_time = time.time()
    print(f"in {(finish_time - start_time):.2f} seconds")

else:

    print("I cannae do it captain. Here's how far I got")
    display_board(tst_board)