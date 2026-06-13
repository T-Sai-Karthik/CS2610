.data
arr: .word 10,10,10,10,10

.section .text
.global main

main:
	la t0,arr
	li t1,5
	li t2,0
		
loop:
	beq t2,t1,end
	lw t4,0(t0)
	
	li t3,1
	and t5,t2,t3
	beq t5,t3,minusone
	bne t5,t3,plusone
	
loop2:
	
	sw t4,0(t0)
	addi t0,t0,4
	addi t2,t2,1
	j loop
	
plusone:
	addi t4,t4,1
	beq t4,t4,loop2
	
minusone:
	addi t4,t4,-1
	beq t4,t4,loop2
	
end:
	li a7,93
	ecall
	
	
