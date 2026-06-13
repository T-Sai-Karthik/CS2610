.section .data
N:        .word 4
buffer:   .space 101
newline: .ascii "\n"

.section .text
.global main

main:
    	lw a0,N
    	lw a1,N
    	li a2,0
    	jal ra,printParens

    	j end

printParens:
    	addi sp,sp,-20
    	sw ra,16(sp)
    	sw a0,12(sp)
    	sw a1,8(sp)
    	sw a2,4(sp)
    	sw s0,0(sp)

	add a3,a0,a1
    	beq a3,x0,print
    	j open

print:
    	la t0,buffer
    	add t0,t0,a2
    	sb zero,0(t0)     

    	li a0,1          
    	la a1,buffer
    	mv a2,a2
    	li a7,64
    	ecall

    	li a0,1
    	la a1,newline
    	li a2,1
    	li a7,64
    	ecall

    	j patch

open:
    	bge x0,a0,close

    	la s0,buffer
    	add s0,s0,a2
    	li t0,'('
    	sb t0,0(s0)

    	addi a0,a0,-1
    	addi a2,a2,1
    	jal ra,printParens
	
    	lw a0,12(sp)
    	lw a1,8(sp)
    	lw a2,4(sp)

close:
    	bge a0,a1,patch

    	la s0,buffer
    	add s0,s0,a2
    	li t0,')'
    	sb t0,0(s0)

    	addi a1,a1,-1
    	addi a2,a2,1
    	jal ra,printParens

patch:
    	lw s0,0(sp)
    	lw a2,4(sp)
    	lw a1,8(sp)
    	lw a0,12(sp)
    	lw ra,16(sp)
    	addi sp,sp,20
    	ret
    
end:
	li a7,93
	ecall
