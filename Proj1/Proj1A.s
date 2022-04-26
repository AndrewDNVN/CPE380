# Data section
# Andrew Donovan CS 380 Proj1
.data

	ArrNA: .asciiz "Array A: "	# Used to print the array names
	ArrNB: .asciiz "Array B: "
	ArrNC: .asciiz "Array C: "
	format:		.asciiz ", "		# Used to format the array values
	newline:	.asciiz "\n"		# Prints a newline

	# Arrays A, B, and C. To modify C change th evalues of A and/or B
	# Note: the arrays must be of equal length
	ArrA: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
	ArrB: .word 9, 8, 7, 6, 5, 4, 3, 2, 1, 100
	ArrC: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

	SIZE:	.word 10

# Text section
.text
.globl main

print_Arr:

	move $s0, $a1

	li $t0, 0
	la $t1, SIZE
	lw $t1, ($t1)
	sub $t1, $t1, 1

	print_loop:
	
	bgt $t0, $t1, end_loop

	lw $a0, ($s0)
	li $v0, 1
	syscall

	beq $t0, $t1, no_form

	la $a0, format 	# load ','
	li $v0, 4
	syscall

	no_form:

	addi $s0, $s0, 4	
	addi $t0, $t0, 1
	j print_loop

		
	end_loop:

	la $a0, newline
	li $v0, 4
	syscall

	jr $ra

final_Out:
	la $a0, ArrNC 	#load name
	
	li $v0, 4	#Print name
	syscall	

	la $a1, ArrC	#load array to be printed
	jal print_Arr

	li $v0, 10	# Exit
			syscall




main: 

	la $a0, ArrNA #load name
	
	li $v0, 4	#Print name
	syscall	

	la $a1, ArrA	#load array to be printed
	jal print_Arr

	la $a0, ArrNB 	#load name
	
	li $v0, 4	#Print name
	syscall	

	la $a1, ArrB	#load array to be printed
	jal print_Arr

	la $a1, ArrA    # Add the contents of ArrayA and ArrayB
	la $a2, ArrB     # Then assign them to ArrayC
	la $a3, ArrC
	#add loop
	
	li $t0, 0
	la $t1, SIZE  	# setting up for looping
	lw $t1, ($t1)
	sub $t1, $t1, 1

	add_loop:
	
	bgt $t0, $t1, end_add

	sll $t2, $t0, 2 	# setting up index in muiltple of four bytes

	add $t3, $t2, $a1	# Making t3 the address of Array A 
	lw $t3, ($t3)

	add $t4, $t2, $a2	# Making t4 the address of Array B
	lw $t4, ($t4)
	
	add $t5, $t3, $t4	# the actual addtion

	add $t6, $t2, $a3	# Making t6 the address of Array C, slighlty ineffeinct but makes for easier reading/following
	sw $t5, 0($t6)

	addi $t0, $t0, 1	# moving the index
	j add_loop

end_add:
	j final_Out
	


	
	
	
		
