.data
DrawInterfaceWhenYouStart: .asciiz "\n  ._________________.\n /|     |     |     |\n ||  1  |  2  |  3  |\n ||_____|_____|_____|\n ||     |     |     |\n ||  4  |  5  |  6  |\n ||_____|_____|_____|\n ||     |     |     |\n ||  7  |  8  |  9  |\n ||.____|_____|_____|.\n |/_________________/\nWelcome to TicTacToe enter number as above to play the game\n"
Array: .word ' ',' ',' ',' ',' ',' ',' ',' ',' ',
XWIN: .asciiz "\nPlayer X Win"
OWIN: .asciiz "\nPlayer O Win"
XEnter: .asciiz "\nEnter Input From 1 to 9 (X): "
OEnter: .asciiz "\nEnter Input From 1 to 9 (O): "
SpaceBar: .word ' ','O','X'
ReInput: .asciiz "This position dose not exits, please try again\n"
Draw: .asciiz "Draw"
L: .asciiz " ||  "
M: .asciiz "  |  "
R: .asciiz "  |"
Top: .asciiz "  ._________________.\n /|     |     |     |\n"
Mid: .asciiz "\n ||_____|_____|_____| \n ||     |     |     |\n"
Bot: .asciiz "\n ||.____|_____|_____|.\n |/_________________/\n"
.text
main:
	li $v0, 4
	la $a0, DrawInterfaceWhenYouStart
	syscall #DrawInterface
	
	
	addi $a3, $0, 0 # A3 = GameContinues = true
	addi $t0, $0, 0 # T0 is count for 9 time
	addi $t1, $0, 0 # T1 = OX = true
	addi $t2, $0, 0 # NumEnter
				# T4 free variable
	la $s2,SpaceBar
	lb $t3, ($s2) # T3 is ' '
	#------------------------------------
	loop:   # while (GameContinues)
	la $s0, Array # S0 is ARRAY
	beq $a3, 1, end
	beq $t0, 9, DrawCase
   	#------------------
		beq $t1, $0, do1       # if(OX)
		else1:  #  else {
	
		li $v0, 4  #cout<<"Enter Input From 1 to 9 (O): ";
		la $a0, OEnter
		syscall
	
		li $v0, 5
		syscall
		move $t2, $v0
		sub $t2, $t2, 1 # From 0 to 9 change to 1 to 9
		sll $t2, $t2, 2 # a*4
		add  $s0, $s0, $t2 #move array pointer point to T2 value	arr[NumEnter]
		lb $t4, ($s0)    	#  *arr[NumEnter]
		
		beq $t4, $t3, do4       #if(arr[NumEnter]==' ')
		else4:                  # else cout<<reInput;
		li $v0, 4
		la $a0, ReInput
		syscall
		j loop
		do4:			#arr[NumEnter]='O'
		la $s3,SpaceBar
		add $s3,$s3,8   # neu co sai quay lai day sua 
		lb $t4, ($s3)
		sw $t4, ($s0)
		end4:
		
		jal DrawInterface
		jal CheckWin
		addi $t1, $0, 0 # T1 = OX = true
	
		j end1  #  end else }
		#-------------------------------------Above is ELSE ----------------------Below is DO--------------------------------
		do1:    #    do  {
	
		li $v0, 4  #cout<<"Enter Input From 1 to 9 (X): ";
		la $a0, XEnter
		syscall
	
		li $v0, 5
		syscall
		move $t2, $v0
		sub $t2, $t2, 1 # From 0 to 9 change to 1 to 9
		sll $t2, $t2, 2 # a*4
		add  $s0, $s0, $t2 #move array pointer point to T2 value	arr[NumEnter]
		lb $t4, ($s0)    	#  *arr[NumEnter]
		
		beq $t4, $t3, do3       #if(arr[NumEnter]==' ')
		else3:                  # else cout<<reInput;
		li $v0, 4
		la $a0, ReInput
		syscall
		j loop
		do3:			#arr[NumEnter]='O'
		la $s3,SpaceBar
		add $s3,$s3,4   # neu co sai quay lai day sua 
		lb $t4, ($s3)
		sw $t4, ($s0)
		end3:
		
		jal DrawInterface
		jal CheckWin
		addi $t1, $0, 1 # T1 = OX = false
		
		end1:   #  end do }
	#-------------------
	add $t0, $t0, 1 #  T0++
	j loop
	DrawCase:
	li $v0, 4 #draw case
	la $a0, Draw
	syscall
	li $v0,10 #end the program
 	syscall
 	
	end:
	#------------------------------------
	#if(OX)
	beq $t1, $0, do2        #check who win 
	else2:
	li $v0, 4
	la $a0, OWIN
	syscall
	j end2
	do2:
	la $a0, XWIN
	syscall
	end2:
	
	li $v0,10 #end the program
 	syscall
 	
 DrawInterface:
 
 la $t4, Array
	
	li $v0, 4 #--------------
	la $a0, Top
	syscall
	#______
	li $v0, 4
	la $a0, L
	syscall
	lb $a0, ($t4)              #loading the character's byte
	li $v0, 11                 #printing the character
	syscall
	
	li $v0, 4
	la $a0, M
	syscall
	add $t4,$t4,4
	lb $a0, ($t4)              #loading the character's byte
	li $v0, 11                 #printing the character
	syscall
	
	li $v0, 4
	la $a0, M
	syscall
	add $t4,$t4,4
	lb $a0, ($t4)              #loading the character's byte
	li $v0, 11                 #printing the character
	syscall

	li $v0, 4
	la $a0, R
	syscall
	#_____
	li $v0, 4 #--------------
	la $a0, Mid
	syscall
	#______
	li $v0, 4
	la $a0, L
	syscall
	add $t4,$t4,4
	lb $a0, ($t4)              #loading the character's byte
	li $v0, 11                 #printing the character
	syscall
	
	li $v0, 4
	la $a0, M
	syscall
	add $t4,$t4,4
	lb $a0, ($t4)              #loading the character's byte
	li $v0, 11                 #printing the character
	syscall
	
	li $v0, 4
	la $a0, M
	syscall
	add $t4,$t4,4
	lb $a0, ($t4)              #loading the character's byte
	li $v0, 11                 #printing the character
	syscall

	li $v0, 4
	la $a0, R
	syscall
	#_____
	li $v0, 4 #--------------
	la $a0, Mid
	syscall
	#______
	li $v0, 4
	la $a0, L
	syscall
	add $t4,$t4,4
	lb $a0, ($t4)              #loading the character's byte
	li $v0, 11                 #printing the character
	syscall
	
	li $v0, 4
	la $a0, M
	syscall
	add $t4,$t4,4
	lb $a0, ($t4)              #loading the character's byte
	li $v0, 11                 #printing the character
	syscall
	
	li $v0, 4
	la $a0, M
	syscall
	add $t4,$t4,4
	lb $a0, ($t4)              #loading the character's byte
	li $v0, 11                 #printing the character
	syscall

	li $v0, 4
	la $a0, R
	syscall
	#______
	li $v0, 4
	la $a0, Bot
	syscall
	
	jr $ra
	
	CheckWin:
		CheckWin1Row:
		la $t4, Array
		lb $t5, 0($t4)		
		lb $t6, 4($t4)		
		lb $t7, 8($t4)
	
		and $t8, $t5, $t6	
		and $t8, $t8, $t7
		
		beq $t8, 'O', Win       
		beq $t8, 'X', Win
		CheckWin2Row:
		la $t4, Array
		lb $t5, 12($t4)		
		lb $t6, 16($t4)		
		lb $t7, 20($t4)
	
		and $t8, $t5, $t6	
		and $t8, $t8, $t7
		
		beq $t8, 'O', Win       
		beq $t8, 'X', Win
		CheckWin3Row:
		la $t4, Array
		lb $t5, 24($t4)		
		lb $t6, 28($t4)		
		lb $t7, 32($t4)
	
		and $t8, $t5, $t6	
		and $t8, $t8, $t7
		
		beq $t8, 'O', Win     
		beq $t8, 'X', Win
		CheckWin1Col:
		la $t4, Array
		lb $t5, 0($t4)		
		lb $t6, 12($t4)		
		lb $t7, 24($t4)
	
		and $t8, $t5, $t6	
		and $t8, $t8, $t7
		
		beq $t8, 'O', Win       
		beq $t8, 'X', Win
		CheckWin2Col:
		la $t4, Array
		lb $t5, 4($t4)		
		lb $t6, 16($t4)		
		lb $t7, 28($t4)
	
		and $t8, $t5, $t6	
		and $t8, $t8, $t7
		
		beq $t8, 'O', Win       # if $t5 = 0, then swap them
		beq $t8, 'X', Win
		CheckWin3Col:
		la $t4, Array
		lb $t5, 8($t4)		
		lb $t6, 20($t4)		
		lb $t7, 32($t4)
	
		and $t8, $t5, $t6	
		and $t8, $t8, $t7
		
		beq $t8, 'O', Win       # if $t5 = 0, then swap them
		beq $t8, 'X', Win
		CheckWinDia1:
		la $t4, Array
		lb $t5, 0($t4)		
		lb $t6, 16($t4)		
		lb $t7, 32($t4)
	
		and $t8, $t5, $t6	
		and $t8, $t8, $t7
		
		beq $t8, 'O', Win       # if $t5 = 0, then swap them
		beq $t8, 'X', Win
		CheckWinDia2:
		la $t4, Array
		lb $t5, 8($t4)		
		lb $t6, 16($t4)		
		lb $t7, 24($t4)
	
		and $t8, $t5, $t6	
		and $t8, $t8, $t7
		
		beq $t8, 'O', Win       # if $t5 = 0, then swap them
		beq $t8, 'X', Win
	jr $ra
		
	Win:
	addi $a3, $0, 1
	jr $ra
	
 	
	
