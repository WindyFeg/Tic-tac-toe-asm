# Tic-tac-toe-asm
a short game using assembly language
# The Algorithms:
Function name `DrawInterfaceWhenYouStart` to illustrate the friendly user interface, also the number from 1 to 9 to know exactly where player can play the game.
  
Function name `DrawInterface` to show each player move.
 
Function `CheckWin` to check 8 case {123, 456, 789, 147, 258, 369, 357, 159} if there any player win or not if so Boolean `GameContinues` become false.
In main function we have:

Boolean `GameContinues` as mention above to check if game need to stop or not.
Boolean `OX` to check we are in player X turn or in player O turn, also to know which player win.
An integer i = 0, we count up to 1 each time a player make a movement until 9 if there is no player win we jump out loop, print “draw” and exit program
An array of character has value ‘ ‘ (spacebar).
  
We have a `Loop:`  as `while(GameContinues)`, Inside loop we have `if(OX)` , `OX` true we play as O player false we play as X player, after we have done implement in parameter we reverse state of  OX.
In each player turn we get player input as integer from 1 to 9 and assign `X` or `O` into the character array.
 
If there already exit one or invalid input we print a warning to player and get input from player again.
 
If the input valid we call `DrawInterface` function to draw, call `CheckWin` to check if any player win, reverse value of `OX` increase i by 1 and  go to `Loop:`   again.
 
If `CheckWin` return `GameContinues` false we break the `Loop:`  and print out the win player (by check `OX`).
 
In case there is no player win through 9 turn, we also break the `Loop:`  and print out draw.
 
