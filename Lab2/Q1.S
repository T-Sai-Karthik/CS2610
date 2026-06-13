.section .data
arr: .word 1,9

.section .text
.global main

main:
	li t1,2
	li t2,0
	
loop1:
	la t0,arr
	beq t1,t2,end
	li t3,0
	sub t4,t1,t2
	addi t4,t4,-1
	
	blt t3,t4,loop2
	
loop1a:
	addi t2,t2,1
	j loop1
	
loop2:
	beq t3,t4,loop1a
	lw t5,0(t0)
	addi t0,t0,4
	lw t6,0(t0)
	
	blt t6,t5,swap
	
loop2a:
	addi t3,t3,1
	j loop2
swap:
	addi a1,t5,0
	addi t5,t6,0
	addi t6,a1,0
	
	sw t6,0(t0)
	addi t0,t0,-4
	sw t5,0(t0)
	addi t0,t0,4
	j loop2a
	
end:
	li a7,93
	ecall
	
	
