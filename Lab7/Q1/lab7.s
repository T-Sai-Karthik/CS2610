.section .text.init
.global _start
_start:
# 1. Initialize Stack Pointer (sp)
	la sp,_stack_top
# 2. Setup Trap Vectors (mtvec)
	la t0, mtrap_handler
	csrw mtvec, t0
# 3. Prepare transition to User Mode (mstatus and mepc)
	li t0, 0x1800
	csrc mstatus, t0
	la t0, ucode
	csrw mepc, t0
# 4. Execute mret to jump to ucode
	mret
	
.section .text
.align 4
mtrap_handler:
# --- Context Saving ---
# Save registers used in ucode. In the ideal case should save all registers.
	addi sp,sp,-32
	sd t0,0(sp)
	sd t1,8(sp)
# --- Decode mcause ---
# Implement logic to handle causes 2, 3, 4, 5, 8
	csrr t0, mcause
	li t1,3
	beq t0,t1,breakpoint
	li t1,2
	beq t0,t1,illegal_instr
	li t1,8
	beq t0,t1,ecall_handler
	li t1,4
	beq t0,t1,l_misalign
	li t1,5
	beq t0,t1,l_acc_fault
	
restore:
	csrr t0, mepc
	addi t0,t0,4
	csrw mepc,t0
# --- Context Restoration ---
	ld t0,0(sp)
	ld t1,8(sp)
	addi sp,sp,32
	mret

breakpoint:
	csrr t0,mepc
	addi t0,t0,-2
	csrw mepc, t0
	li a0, 0xBEEF
	j restore
	
illegal_instr:
	csrr s9, mtval
	j restore
	
ecall_handler:
	li a0, 0xFEED
	j restore
	
l_misalign:
	csrr s10,mtval
	j restore
	
l_acc_fault:
	csrr s11,mtval
	j restore
	
ucode:
    # --- Sequence of Exception Tests ---
    # Trigger exceptions one after another to test your handler logic
    la t0, ucode
    addi t0,t0,1
    ld t0,0(t0)
    .word 0x00000000
    ebreak
    li t0, 0x0
    ld t1, 0(t0)
    ecall
    j .

.section .bss
.align 16
_stack_low:
.space 4096
_stack_top:
