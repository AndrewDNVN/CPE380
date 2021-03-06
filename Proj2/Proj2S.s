# Andrew Donovan
# CPE 380 Proj2
# 10/26/2019
.data

ArrNA: .asciiz "Array is: "

ArrA: .word 1, 2, 8, 7, 2, 0, 3, 0, 0, 0

arrend:

OddArr: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

format: .asciiz ","
newline:.asciiz "\n"

odd_Output: .asciiz "The sum of the odd values in the array is: "

SIZE: .word 10

DIVSOR: .word 2

.text

print_Arr:

move $t4, $a1

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

	la $a0, format
	li $v0, 4
	syscall

	no_form:
	
	addi $t4, $t4, 4
	addi $t0, $t0, 1
	j print_loop

	end_loop:

	la $a0, newline
	li $v0, 4
	syscall

	jr $ra
	
main:

la $a0, ArrNA

li $v0, 4
syscall

la $a1, ArrA
jal print_Arr

li $t0, 0
li $t1, 0
la $t6, ArrA
la $t7, arrend

find_loop:

	bge $t6, $t7, found_done
 	
	lw $t2, 0($t6)
	addiu $t6, $t6, 4

	andi $t3, $t2, 1
	beqz $t3, find_even

	add $t1, $t1, $t2
	jr find_loop

find_even:
	# add $t0, $t0, $t2
	jr find_loop

found_done:

	la $a0, odd_Output
	la $v0, 4
	syscall

	move $a0, $t1

	la $v0, 1
	syscall

	jr EXIT

EXIT:

li $v0, 10
syscall
