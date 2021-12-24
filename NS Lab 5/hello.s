.text
.globl main
main:
addiu $t7, $sp, 40

li $a0, 5
sw $a0, 0($t7)

li $a0, 0
sw $a0, 16($t7)

lw $a0, 0($t7)
sw $a0, 0($sp)
addiu $sp, $sp, 16

li $a0, 10
sw $a0, 0($sp)
addiu $sp, $sp, 16

#==========lt==========
addiu $sp, $sp, -16
lw $a0, 0($sp)

addiu $sp, $sp, -16
lw $t1, 0($sp)

slt $a0, $t1, $a0
addiu $sp, $sp, 16

beq $a0, 0, LABEL1

li $a0, 1
sw $a0, 16($t7)
b LABEL2

LABEL1:
li $a0, 11
sw $a0, 16($t7)

LABEL2:

li $v0, 1
move $t0, $a0
syscall

li $v0, 10
syscall