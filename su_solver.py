tst_board = [[4,0,3,0,0,0,1,0,5],
             [0,6,0,9,0,0,0,0,0],
             [0,0,0,0,1,0,0,4,6],
             [9,3,2,0,8,1,0,7,4],
             [0,0,0,0,9,7,3,0,0],
             [0,1,4,0,2,6,9,5,8],
             [0,4,7,8,3,0,0,0,0],
             [0,0,0,0,4,0,5,0,0],
             [6,0,9,1,0,0,0,8,0]]

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

def find_empty(board):
    emptys = []
    for i in range (9):
        for j in range (9):
            if board[i][j] == 0: 
                emptys.append((i,j))      #if empty, add to the list

    if emptys: return emptys            #return list of empty cells

    else: return False                #if no cells are empty, return false


def find_valid(board, pos):
    digits = list(range(1,10))                              #find all valid digits for a given cell and return them

    for i in range(9):                                      #check against same row and column
        for j in range (9):
            if board[pos[0]][i] in digits:
                digits.remove(board[pos[0]][i])

            if board[j][pos[1]] in digits:
                digits.remove(board[j][pos[1]])        

    for i in range(int(pos[0]/3)*3, int(pos[0]/3)*3 +3):      #check against 3x3 cell
        for j in range (int(pos[1]/3)*3, int(pos[1]/3)*3+3):
            if board[i][j] in digits:
                digits.remove(board[i][j])

    return digits

def solve(board):
    valids_board = [[0 for i in range(9)] for j in range(9)]                              #initialise board to hold valid digits

    while find_empty(tst_board):
        empty_pos = find_empty(tst_board)                   #find all empty cells 
        for i in empty_pos:                                 #and loop through them
            valids = find_valid(tst_board, i)               #find what numbers are valid for that cell   
            valids_board[i[0]][i[1]] = valids               #store all valids to valids_board

            if len(valids) == 1:                            #if only 1 valid number
                tst_board[i[0]][i[1]] = valids[0]           #insert that number to the board
                valids_board[i[0]][i[1]] = 0                #remove any digits from the corresponding valids_board
                continue


        find_uniques(valids_board)




            #if i == empty_pos[-1]:                         #if we reach the final empty cell and still don't have a solution...
             #   break                                      #break out 

        
        break

def find_uniques(v_board):
    for i in range(9):
        for j in range(9):
            if not v_board[i][j] == 0:                      #loop through valids_board searching for unsolved cells
                pos = i,j                                   
                exclusive = set(v_board[pos[0]][pos[1]])
                for x in range(9):
                    if v_board[i][x] and not (i,x) == (pos):        #if not the current cell and not a solved cell
                        exclusive = exclusive - set(v_board[i][x])  #subtract the valids from our current cells valids  
                for y in range(9):
                    if v_board[y][j] and not (y,j) == (pos):
                        exclusive = exclusive - set(v_board[y][j])

                print("\n\n")##############################
                display_board(tst_board)#####################

                for x in range (int(i/3), int(i/3) * 3 + 3):            #3x3 grid check
                    for y in range(int(j/3), int(j/3)* 3 + 3 ):
                        if v_board[x][y] and not (x,y) == (pos):
                            exclusive = exclusive - set(v_board[x][y])
                    

                if len(exclusive) == 1:
                    tst_board[pos[0]][pos[1]] = list(exclusive)[0]


#########start of program###########

display_board(tst_board)
#input("Press Enter to solve")  
solve(tst_board)

print("\n\n")
display_board(tst_board)