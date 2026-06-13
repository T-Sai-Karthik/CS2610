.section .data
A: .word 8
B: .word 7
res_add: .word 0
res_sub: .word 0
res_and: .word 0
res_or: .word 0
res_xor: .word 0

.section .text
.global main

main:
	la t0,A
	lw t1,0(t0)
	la t0,B
	lw t2,0(t0)
	
	add t4,t1,t2
	la t3,res_add
	sw t4,0(t3)
	
	sub t4,t1,t2
	la t3,res_sub
	sw t4,0(t3)
	
	and t4,t1,t2
	la t3,res_and
	sw t4,0(t3)
	
	or t4,t1,t2
	la t3,res_or
	sw t4,0(t3)
	
	not t4,t1
	xor t5,t4,t2
	la t3,res_xor
	sw t5,0(t3)

end:
	li a7,93
	ecall
	
	
