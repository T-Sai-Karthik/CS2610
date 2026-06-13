.section .text
.global main

main:
    # Prepare jump to super mode
    li t1, 1
    slli t1, t1, 11   #mpp_mask
    csrs mstatus, t1
    
    la t4, supervisor       #load address of user-space code
    csrrw zero, mepc, t4    #set mepc to user code
    
    la t5, page_fault_handler
    csrw mtvec, t5
   
    mret

supervisor:
################## Setting up page tables ##############
    # Set value in PTE2 (Initial Mapping)
    li a0,0x81000000
    li a1, 0x82000
    slli a1, a1, 0xa
    ori a1, a1, 0x01 # | - | - | - |V
    sd a1, 16(a0)

    # To set V.A 0x0 -> P.A 0x0
    li a1, 0x82001
    slli a1, a1, 0xa
    ori a1, a1, 0x01 # | - | - | - |V
    sd a1, 0(a0)

    # Set value in PTE1 (Initial Mapping)
    li a0,0x82000000
    li a1, 0x83000
    slli a1, a1, 0xa
    ori a1, a1, 0x01 # | - | - | - |V
    sd a1, 0(a0)

    # Set Frame number in PTE0 (Initial Mapping)
    li a0,0x83000000
    li a1, 0x80000
    slli a1, a1, 0xa
    ori a1, a1, 0xef # D | A | G | - | X | W | R |V
    sd a1, 0(a0)

    li a1, 0x80001
    slli a1, a1, 0xa
    ori a1, a1, 0xef # D | A | G | - | X | W | R |V
    sd a1, 8(a0)

    # Set value in PTE1 (Code Mapping)
    li a0,0x82001000
    li a1, 0x83001
    slli a1, a1, 0xa
    ori a1, a1, 0x01 # | - | - | - |V
    sd a1, 0(a0)

    # Set value in PTE0 (Code Mapping)
    li a0,0x83001000
    li a1, 0x80001
    slli a1, a1, 0xa
    ori a1, a1, 0xfb # D | A | G | U | X | - | R |V
    sd a1, 0(a0)

    # Data Mapping
    li a1, 0x80002
    slli a1, a1, 0xa
    ori a1, a1, 0xf7 # D | A | G | U | - | W | R |V
    sd a1, 8(a0)
    

####################################################################

    # Prepare jump to user mode
    li t1, 0
    slli t1, t1, 8   #spp_mask
    csrs sstatus, t1

    # Configure satp
    la t1, satp_config 
    ld t2, 0(t1)
    sfence.vma zero, zero
    csrrw zero, satp, t2
    sfence.vma zero, zero

    li t4, 0       # load VA address of user-space code
    csrrw zero, sepc, t4    # set sepc to user code
    
    sret



###################################################################
##################### ADD CODE ONLY HERE  #########################
###################################################################
.align 4
page_fault_handler:

    j pf_start

    .align 3
next_code_page: .dword 0x80003000
next_l0_page:   .dword 0x83002000
reg_save:       .space 80

pf_start:
    csrw mscratch, t0
    la t0, reg_save
    sd t1, 8(t0)
    csrr t1, mscratch
    sd t1, 0(t0)
    sd t2, 16(t0)
    sd t3, 24(t0)
    sd t4, 32(t0)
    sd t5, 40(t0)
    sd t6, 48(t0)
    sd a0, 56(t0)
    sd a1, 64(t0)
    sd a2, 72(t0)

    csrr t1, mcause
    csrr t2, mtval

    srli t3, t2, 21
    li t4, 0x1FF
    and t3, t3, t4

    srli t4, t2, 12
    li t5, 0x1FF
    and t4, t4, t5

    li t5, 0x82001000
    slli t6, t3, 3
    add t5, t5, t6

    ld a0, 0(t5)
    andi a1, a0, 1
    bnez a1, l0_pt_exists

    la t6, next_l0_page
    ld a0, 0(t6)

    li a1, 0x1000
    add a1, a0, a1
    sd a1, 0(t6)

    srli a1, a0, 2
    ori a1, a1, 1
    sd a1, 0(t5)

    mv a1, a0
    li a2, 0x1000
    add a2, a1, a2
zero_loop:
    sd zero, 0(a1)
    addi a1, a1, 8
    blt a1, a2, zero_loop

    j calc_l0_pte_addr

l0_pt_exists:
    srli a0, a0, 10
    slli a0, a0, 12

calc_l0_pte_addr:
    slli t6, t4, 3
    add a0, a0, t6

    li t5, 12
    beq t1, t5, inst_fault
    li t5, 13
    beq t1, t5, data_fault
    li t5, 15
    beq t1, t5, data_fault
    j pf_end

inst_fault:
    la t6, next_code_page
    ld a1, 0(t6)

    li t5, 0x1000
    add t5, a1, t5
    sd t5, 0(t6)

    li t5, 0x80001000
    li t6, 4096
    add t6, t5, t6
copy_loop:
    ld a2, 0(t5)
    sd a2, 0(a1)
    addi t5, t5, 8
    addi a1, a1, 8
    blt t5, t6, copy_loop

    li t5, 0x1000
    sub a1, a1, t5
    srli a1, a1, 2
    ori a1, a1, 0xFB
    sd a1, 0(a0)
    j pf_end

data_fault:
    li a1, 0x80002000
    srli a1, a1, 2
    ori a1, a1, 0xF7
    sd a1, 0(a0)

pf_end:
    sfence.vma zero, zero

    la t0, reg_save
    ld t1, 8(t0)
    ld t2, 16(t0)
    ld t3, 24(t0)
    ld t4, 32(t0)
    ld t5, 40(t0)
    ld t6, 48(t0)
    ld a0, 56(t0)
    ld a1, 64(t0)
    ld a2, 72(t0)
    ld t0, 0(t0)

    mret
###################################################################
###################################################################



.align 12
user_code:
    la t1,var_count
    lw t2, 0(t1)
    addi t2, t2, 1
    sw t2, 0(t1)

    la t5, code_jump_position
    lw t3, 0(t5)
    li t4, 0x2000
    add t3, t3, t4
    sw t3, 0(t5)
    
    jalr x0, t3


.data
.align 12
var_count:  .word  0
code_jump_position: .word 0x0000


.align 8
# Value to set in satp
satp_config: .dword 0x8000000000081000
