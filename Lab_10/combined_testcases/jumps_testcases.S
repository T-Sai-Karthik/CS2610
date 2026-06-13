.section .text
.global _start

_start:
    /* -------------------------------------------------
       Harness setup (DO NOT TOUCH LATER)
       ------------------------------------------------- */
    /* x5 = OUTPUT = 0x00008000 */
    lui   x5, 0x00008
    addi  x5, x5, 0

/* =====================================================
   TEST J1 — JAL redirects PC (no fall-through)
   ===================================================== */
J1:
    jal   x8, J1_target
    j     J1_fail          /* fall-through => JAL broken */

J1_after:                  /* PC+4 return point */
    li    x6, 0x51
    sw    x6, 0(x5)
    j     J2

J1_fail:
    li    x6, 0x50
    sw    x6, 0(x5)
    j     J1_fail

J1_target:
    jalr  x0, 4(x8)        /* return to J1_after */

/* =====================================================
   TEST J2 — JAL link = PC + 4
   ===================================================== */
J2:
    auipc x7, 0             /* x7 = PC of AUIPC */
    addi  x7, x7, 8         /* expected link = PC+4 of JAL */

    jal   x8, J2_target
    j     J2_fail

J2_after:
    bne   x8, x7, J2_fail
    li    x6, 0x53
    sw    x6, 0(x5)
    j     J3

J2_fail:
    li    x6, 0x52
    sw    x6, 0(x5)
    j     J2_fail

J2_target:
    jalr  x0, 4(x8)

/* =====================================================
   TEST J3 — JAL rd = x0 suppresses link
   ===================================================== */
J3:
    jal   x0, J3_target
    j     J3_fail

J3_after:
    bne   x0, x0, J3_fail  /* x8 must be unchanged */
    li    x6, 0x55
    sw    x6, 0(x5)
    j     J4

J3_fail:
    li    x6, 0x54
    sw    x6, 0(x5)
    j     J3_fail

J3_target:
  jal   x0, J3_after

/* =====================================================
   TEST J4 — JALR register target works (CORRECT)
   ===================================================== */

J4:
    /* x7 = address of J4_target */
    auipc x7, 0
    addi  x7, x7, (J4_target - J4)

    /* x8 = return address = J4_after */
    auipc x8, 0
    addi  x8, x8, (J4_after - J4)

    jalr  x0, 0(x7)
    j     J4_fail

J4_after:
    li    x6, 0x57
    sw    x6, 0(x5)
    j     J5

J4_fail:
    li    x6, 0x56
    sw    x6, 0(x5)
    j     J4_fail

J4_target:
    jalr  x0, 0(x8)    /* explicit, correct return */

/* =====================================================
   TEST J5 — JALR clears bit[0] of target
   ===================================================== */
J5:
    auipc x7, 0
    addi  x7, x7, (J5_target - J5)
    addi  x7, x7, 1        /* force LSB = 1 */

    jalr  x0, 0(x7)
    j     J5_fail

J5_after:
    li    x6, 0x59
    sw    x6, 0(x5)
    j     PASS

J5_fail:
    li    x6, 0x58
    sw    x6, 0(x5)
    j     J5_fail

J5_target:
    jalr  x0, 0(x1)

/* =====================================================
   ALL JUMPS PASSED
   ===================================================== */
PASS:
    li    x6, 0x5F
    sw    x6, 0(x5)
    j     PASS
