tst_board = [[6,5,0,0,0,7,7,0,3],
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

def find_valid(board):
                    



display_board(tst_board)
input("Press Enter to solve")


