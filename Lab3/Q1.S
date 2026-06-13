.section .data
N: .word 6789

.section .text
.global main

main:
	lw t0,N
	li t1,10
	rem a0,t0,t1
	jal ra,sumDigits
	li a7,93
	ecall
	
sumDigits:
	addi sp,sp,-16
	sd ra,8(sp)
	sd a0,0(sp)

	blt t0,t1,singleDig
	
recurse:
	div t0,t0,t1
	rem a0,t0,t1
	jal ra, sumDigits
	ld t2,0(sp)
	add a0,a0,t2
	j exit
	
singleDig:
	addi t0,t0,0
	
exit:
	ld ra,8(sp)
	addi sp,sp,16
	
	ret
	
	
