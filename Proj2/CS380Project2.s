# Course: CS 380-001
# Project 2: Write a program that receives an array of length 10
#			 and returns the sum of odd elements (numbers) in this array.
# Author: Zack Mathias
# SID: 12085846
# Date: 10/27/2019
# Purpose: Read input from user.
# References: None

# Data section
.data

	# Messages to print for the user
	Input_Message: 	.asciiz "Input 10 numbers:\n"
	Sum_Message:	.asciiz "Sum of odd numbers is: "

	# Used when we print the current input number
	format:			.asciiz ") "

# Text section
.text
.globl main

	main:

		la $a0, Input_Message 	# Print message for input
		li $v0, 4
		syscall

		li $t0, 0				# Index = 0
		li $t1, 9				# Size - 1
		li $t2, 0				# Sum of odd numbers

		read_loop:

			bgt $t0, $t1 end_read_loop 	# Index > size - 1

			addi $t0, $t0, 1			# Index++

			la $a0, ($t0) 				# Print index for user
			li $v0, 1
			syscall

			la $a0, format 				# Print format
			li $v0, 4
			syscall

			li $v0, 5 					# Read an integer
			syscall

			andi $t3, $v0, 1 			# Bitwise AND the input with 1 
			beq $t3, $zero, read_loop 	# if it's equal to zero the number is even

			add $t2, $t2, $v0 			# Add the number to our sum
			j read_loop 

		end_read_loop:

		la $a0, Sum_Message 	# Print out message for sum
		li $v0, 4
		syscall

		la $a0, ($t2) 			# Print the sum
		li $v0, 1
		syscall

		li $v0, 10 				# Exit
		syscall