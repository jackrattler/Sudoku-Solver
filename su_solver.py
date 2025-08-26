tst_board = [[6,5,0,0,0,7,9,0,3],
             [0,0,2,1,0,0,6,0,0],
             [9,0,0,0,6,3,0,0,4],
             [1,2,9,0,0,0,0,0,0],
             [3,0,4,9,0,8,1,0,0],
             [0,0,0,3,0,0,4,7,9],
             [0,0,6,0,8,0,3,0,5],
             [7,4,0,5,0,0,0,0,1],
             [5,8,1,4,0,0,0,2,6]]

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
    for i in range (9):
        for j in range (9):
            if board[i][j] == 0: 
                return i,j      #if empty, return the position
    
    return False                #if no cells are empty, return false


def find_valid(board, pos):
    digits = list(range(1,10))

    for i in range(9):                              #check against same row and column
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


display_board(tst_board)
input("Press Enter to solve")

#find an empty cell
while find_empty:
    empty_pos = find_empty(tst_board)                       
    valids = find_valid(tst_board, empty_pos)               #find what numbers are valid for that cell   

    if len(valids) == 1:                                        #if only 1 valid number
        tst_board[empty_pos[0]][empty_pos[1]] = valids[0]       #insert that number to the board

    else: break


display_board(tst_board)