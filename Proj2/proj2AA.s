# Andrew Donovan
# CPE 380 Proj2

.data

	User_Input: .asciiz "Enter 10 numbers: \n"
	End_mess: .asciiz "The sum of the Odd numbers entered is:  "

	format: .asciiz": "

	SIZE: .word 10

.text

main:
	
jal init

j user_loop

init:

la $a0, User_Input
li $v0, 4
syscall

li $t0, 0 

la $t1, SIZE
lw $t1, ($t1)
sub $t1, $t1, 1

li $t2, 0 

jr $ra

user_loop:

bgt $t0, $t1, final

addi $t0, $t0, 1

la $a0, ($t0)
li $v0, 1 
syscall

la $a0, format
li $v0, 4
syscall

li $v0, 5
syscall

andi $t3, $v0, 1
beq $t3, $zero, user_loop

add $t2, $t2, $v0
j user_loop
	
final:

la $a0, End_mess
li $v0, 4
syscall

la $a0, ($t2)
li $v0, 1
syscall

li $v0, 10
syscall