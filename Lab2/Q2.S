.data
A: .word 1,2,3,4,5,6,7,8,9
B: .word 1,1,1,1,1,1,1,1,1
C: .word 0,0,0,0,0,0,0,0,0

.section .text
.global main

main:
	la t0,A
	la t1,B
	la t2,C
	li s1,3
	li a0,0
	li a3,0
	li a4,0
loop1:
	beq a0,s1,end
	li a1,0
	blt a1,s1,loop2
	
loop1a:
	addi t0,t0,12
	addi t1,t1,-12
	addi a0,a0,1
	j loop1
	
loop2:
	beq a1,s1,loop1a
	li a2,0
	li s2,0
	blt a2,s1,loop3
	
loop2a:
	sw s2,0(t2)
	addi t2,t2,4
	addi t0,t0,-12
	addi t1,t1,-32
	addi a1,a1,1
	j loop2
	
loop3:
	beq a2,s1,loop2a
	lw t3,0(t0)
	lw t4,0(t1)
	mul t5,t3,t4
	add s2,s2,t5
	
	addi t0,t0,4
	addi t1,t1,12
	addi a2,a2,1
	j loop3
	
end:
	li a7,93
	ecall
	
	
