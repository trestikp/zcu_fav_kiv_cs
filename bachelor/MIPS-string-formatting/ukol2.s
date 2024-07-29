# data segment
	.data
name: 	.asciiz "String editing\n"
diag_1: .asciiz "Enter string: "
diag_2: .asciiz "Enter instruction: "
error: 	.asciiz "Invalid position!\n"
length: .byte 	0

input: 		.space 101
		.align 2
instruction: 	.space 11

# code segment
# s0 = instruction type
# s1 = position
# s2 = input character (in case of i)
	.text
	.globl main
	.ent main
main:
	# print program name
	li $v0, 4
	la $a0, name
	syscall

	# print string entry diag
	la $a0, diag_1
	syscall

	# load string from console
	li $v0, 8
	la $a0, input
	# allocate input size
	li $a1, 101
	syscall
	
	# count input length
	jal count_input_length

	# jump to load_instruction
	j load_instruction

.end main

# prompts the user to enter an instruction to carry out on entered string
load_instruction:
	# clear registers (for sure due to previous runs)
	# theoretically not necessary
	jal clear_registers

	# print instruction entry diag
	li $v0, 4
	la $a0, diag_2
	syscall

	# load instruction from console
	li $v0, 8
	la $a0, instruction
	# allocate instruction memory
	li $a1, 11
	syscall

	# moves inctruction to t0 register
	la $t0, instruction
	nop

	# sets t7 to 10 to use for sum position count
	li $t7, 10

	# call process_instruction - gets instruction type
	jal process_instruction
	nop	

	# calls appropriete instruction
	beq $s0, 100, extract_delete # first char = d
	nop
	beq $s0, 105, extract_insert # first char = i
	nop
	beq $s0, 101, finish
	nop

	# theoretically not reached, but in case
	# jumps to load_instruction so the program
	# can't just start doing code bellow
	j load_instruction
.end load_instruction

# parses the instruction to registers
process_instruction:

	# moves first char of instruction to s0 register
	lb $s0, ($t0)
	nop
	
	# shift instruction and put it to t1
	# preparation to extract position from instruction
	add $t0, $t0, 1

	# get back to the upper branch
	jr $ra
	nop

.end process_instruction 

extract_delete: 
	# load unsigned first char of the position in instruction
	lbu $t1, ($t0)
	nop

	# when <lf> is reached 
	beq $t1, 10, do_delete
	nop

	# if char is less then 0
	blt $t1, 48, position_error
	nop

	# if char is more then 9
	bgt $t1, 57, position_error
	nop

	# char to number
	addi $t1, $t1, -48

	# shifts point
	mul $s1, $s1, $t7

	# adds latest loaded number
	add $s1, $s1, $t1

	# shift to next char
	addi $t0, $t0, 1

	# repeat
	j extract_delete
	nop

.end extract_delete

extract_insert:
	# reads first char
	lbu $t1, ($t0)	
	nop

	# read second character
	lbu $t2, 1($t0)
	nop

	# if then second character is <lf>
	# ends and calls get_replacement
	beq $t2, 10, get_replacement

	# if char is less then 0
	blt $t1, 48, position_error
	nop

	# if char is more then 9
	bgt $t1, 57, position_error
	nop

	# char to number
	addi $t1, $t1, -48

	# shifts point
	mul $s1, $s1, $t7

	# adds latest loaded number
	add $s1, $s1, $t1

	# shift to next char
	addi $t0, $t0, 1

	# repeat
	j extract_insert
	nop

.end extract_insert

get_replacement:
	# more or less useless move from t2 to s2
	# because it is used and removed immediatly
	move $s2, $t1

	j do_insert

.end get_replacement

# uses $t0 for char iterator (address)
# uses $t1 for first char at $t0 address
# uses $t2 for second char at $t0 address
# uses $t3 for length of input
do_delete:

	# null used registers
	add $t0, $zero, $zero
	add $t1, $zero, $zero
	add $t2, $zero, $zero
	add $t3, $zero, $zero

	# $t0 is input address
	la $t0, input
	# $t3 is input length
	lb $t3, length
	nop

	# position is more then length
	#bgt $s1, $t3, position_error
	# equals to prevent counting \0
	# as a char!
	bge $s1, $t3, position_error

	# change address in t0 to position of delete
	add $t0, $t0, $s1

	# will be deleting char, dec length + save to mem
	sub $t3, $t3, 1
	sb $t3, length

delete_while:

	# load first and second char at $t0 
	lb $t1, ($t0)
	lb $t2, 1($t0)

	# if first char is \0 branch to print string
	#beq $t1, 0, print_delete	
	beq $t1, 0, print_result

	# store second letter at $t0 
	sb $t2, ($t0)

	# shifts to next address
	addi $t0, $t0, 1

	j delete_while

.end extract_delete

	# theoretically unreached, just
	# to ensure the program alwasy runs
	j load_instruction

.end do_delete

# simple output to console
# outputs string, which is changed with
# instructions
# !! for some reason must be here, if
# moved under do_insert, won't work in
# do_delete
print_result:

	li $v0, 4
	la $a0, input
	syscall

	j load_instruction

.end print_result

do_insert:

	# null used registers
	add $t0, $zero, $zero
	add $t1, $zero, $zero
	add $t2, $zero, $zero
	add $t3, $zero, $zero
	#add $t4, $zero, $zero

	# $t0 is input address
	la $t0, input

	# $t3 is input length
	lb $t3, length
	nop

	# position is more then length
	#bgt $s1, $t3, position_error
	# equals to prevent counting \0
	# as a char
	bge $s1, $t3, position_error

	# change address in t0 to position of insert
	add $t0, $t0, $s1

	# load insert char to $t2
	move $t2, $s2

	# will be inserting char, inc length + save to mem
	addi $t3, $t3, 1
	sb $t3, length

	# prepare register to insert entered char
	lb $t1, ($t0)
	move $t2, $s2

insert_while:

	# if end of string -> end insert + print
	beq $t1, 0, print_result

	# save char to mem
	sb $t2, ($t0)

	# char from prev pos to new pos
	move $t2, $t1

	# inc insert position value
	addi $t0, $t0, 1

	# loads first char from addres @ $t0
	# to $t1
	lb $t1, ($t0)

	j insert_while

.end insert_while

	# theoretically unreached, just
	# to ensure the program alwasy runs
	j load_instruction

.end do_insert

# simple output to consloe
# outputs invalid position error
position_error:

	li $v0, 4
	la $a0, error
	syscall

	j load_instruction

.end position_error

# simply sets most of repeatadly used
# registers to 0
clear_registers:

	add $t0, $zero, $zero	
	add $t1, $zero, $zero	
	add $t2, $zero, $zero	
	add $t3, $zero, $zero	
	add $s0, $zero, $zero	
	add $s1, $zero, $zero	
	add $s2, $zero, $zero	

	jr $ra
	nop

.end clear_registers

# counts number of chars in entered string
count_input_length:

	# loads input address to $t0
	la $t0, input
	# nulls $t2
	add $t2, $zero, $zero

count_while:
	
	# inc $t2
	addi $t2, $t2, 1	

	# move first char of $t0 address to $t1
	lb $t1, ($t0)

	# inc $t0 - address
	addi $t0, $t0, 1

	# if $t1 - "next" char isnt new line
	# goto count_while
	bne $t1, 10, count_while

.end count_while
	# save $t2 (temp. count) to memory
	# @length address (more or less useless
	# could just keep it in the register
	# for better performance)
	sb $t2, length

	# return to calling position
	jr $ra
	nop

.end count_input_length

# exits the program
finish:

	li $v0, 10
	syscall

.end finish
