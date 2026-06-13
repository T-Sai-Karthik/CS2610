.section .data
A: .word 1
B: .word 2
.section .text
.global main
main:
# Configure CSR registers (medeleg, mstatus, mepc, mtvec, stvec etc.)
	li t0, 0x100
	csrs medeleg, t0
	li t0, 0x1800
	csrc mstatus, t0
	la t0, ucode
	csrw mepc, t0
	la t0, mtrap_handler
	csrw mtvec, t0
	la t0, strap_handler
	csrw stvec, t0
# Execute mret to initiate downward transition to User code
	mret

.align 4

mtrap_handler:
# Process traps originating from the strap_handler
	csrr t6, mstatus
# Perform the multiplication operation
	mul a1, a1, a2
# Flip a0 to 0
	li a0, 0
	li t0, 0x1800
	csrc mstatus, t0
	li t0, 0x800
	csrs mstatus, t0
# Set mepc back to strap_handler and execute mret
	la t0, strap_handler
	csrw mepc, t0
	mret

scode:
# Execute sret to initiate transition to User mode after setting the CSRs
	la t0, ucode1
	csrw sepc, t0
	li t0, 0x100
	csrc sstatus, t0
	sret

.align 4

strap_handler:
# The Dispatcher
	csrr t6, sstatus
# Check if a0 == 0 or a0 == 1
# If a0 == 0: jump to scode (to setup S to U transition)
# If a0 == 1: execute ecall to jump up to mtrap_handler
	beq a0, x0, scode
	ecall

ucode:
# Note: Handle initial variable loading here if using a single User block
	la t0, A
	lw a1, 0(t0)
	la t0, B
	lw a2, 0(t0)
	
	li a0, 0
	ecall

ucode1:
# Perform the addition operation
	add a1, a1, a2
# Flip a0 to 1
	li a0, 1
# The ecall should invoke the supervisor’s trap handler
	ecall
