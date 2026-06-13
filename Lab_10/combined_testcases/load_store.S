
.section .text
.global _start
_start:

# ==============================================================================
# SETUP BASE ADDRESS
# ==============================================================================
  # We assume 0x1000 is a valid writable data region.
  li x10, 0x1000

# ==============================================================================
# PART 1: EXHAUSTIVE STORES
# Writing various bit patterns to consecutive memory locations.
# ==============================================================================

  # --- 1. Store Word (SW) Patterns ---
  
  # Offset 0: Standard Pattern
  li x1, 0xDEADBEEF
  sw x1, 0(x10)

  # Offset 4: All Ones (-1)
  li x1, -1          # 0xFFFFFFFF
  sw x1, 4(x10)

  # Offset 8: All Zeros
  li x1, 0
  sw x1, 8(x10)

  # Offset 12: Min Integer (Bit 31 set, others 0)
  li x1, 0x80000000
  sw x1, 12(x10)

  # Offset 16: Alternating Bits 1 (0xAAAAAAAA)
  li x1, 0xAAAAAAAA
  sw x1, 16(x10)

  # Offset 20: Alternating Bits 2 (0x55555555)
  li x1, 0x55555555
  sw x1, 20(x10)


  # --- 2. Store Half (SH) Patterns ---
  # We will write to new offsets to test Half-word granular writes.
  
  # Offset 24: Write -1 (0xFFFF) as Half
  li x1, -1
  sh x1, 24(x10)

  # Offset 26: Write Max Positive Half (0x7FFF)
  li x1, 0x7FFF
  sh x1, 26(x10)


  # --- 3. Store Byte (SB) Patterns ---
  # Offset 28: Write -1 (0xFF) as Byte
  li x1, -1
  sb x1, 28(x10)

  # Offset 29: Write Max Signed Byte (0x7F)
  li x1, 0x7F
  sb x1, 29(x10)

  # Offset 30: Write Random Byte (0x55)
  li x1, 0x55
  sb x1, 30(x10)


  # --- 4. Endianness/Overlap Construction ---
  # We build a word manually using bytes to test byte-ordering.
  # We want the word at Offset 32 to become 0x11223344.
  # Assuming Little Endian:
  li x1, 0x44
  sb x1, 32(x10)     # Byte 0
  li x1, 0x33
  sb x1, 33(x10)     # Byte 1
  li x1, 0x22
  sb x1, 34(x10)     # Byte 2
  li x1, 0x11
  sb x1, 35(x10)     # Byte 3


# ==============================================================================
# PART 2: DELAY BLOCK
# Insert instructions to ensure previous Stores have settled in memory/cache
# and to prevent simple forwarding paths from masking bugs.
# ==============================================================================
  nop
  nop
  nop
  nop
  nop
  addi x1, x0, 10
  addi x1, x1, -1
  nop
  nop
  nop
  nop
  nop


# ==============================================================================
# PART 3: EXHAUSTIVE LOADS & VERIFICATION
# ==============================================================================

  # --- 1. Verify Word Stores (LW) ---

  # Offset 0: Expect 0xDEADBEEF
  lw x2, 0(x10)
  li x3, 0xDEADBEEF
  bne x2, x3, fail

  # Offset 4: Expect -1 (0xFFFFFFFF)
  lw x2, 4(x10)
  li x3, -1
  bne x2, x3, fail

  # Offset 8: Expect 0
  lw x2, 8(x10)
  bne x2, x0, fail

  # Offset 12: Expect 0x80000000
  lw x2, 12(x10)
  li x3, 0x80000000
  bne x2, x3, fail

  # Offset 16: Expect 0xAAAAAAAA
  lw x2, 16(x10)
  li x3, 0xAAAAAAAA
  bne x2, x3, fail

  # Offset 20: Expect 0x55555555
  lw x2, 20(x10)
  li x3, 0x55555555
  bne x2, x3, fail


  # --- 2. Verify Half Stores (LH vs LHU) ---
  
  # Offset 24: Stored 0xFFFF (-1).
  # LH should Sign-Extend to 0xFFFFFFFF
  lh x2, 24(x10)
  li x3, -1
  bne x2, x3, fail

  # LHU should Zero-Extend to 0x0000FFFF
  lhu x2, 24(x10)
  li  x3, 0xFFFF
  bne x2, x3, fail

  # Offset 26: Stored 0x7FFF.
  # LH should be 0x00007FFF
  lh x2, 26(x10)
  li x3, 0x7FFF
  bne x2, x3, fail


  # --- 3. Verify Byte Stores (LB vs LBU) ---

  # Offset 28: Stored 0xFF (-1).
  # LB should Sign-Extend to 0xFFFFFFFF
  lb x2, 28(x10)
  li x3, -1
  bne x2, x3, fail

  # LBU should Zero-Extend to 0x000000FF
  lbu x2, 28(x10)
  li  x3, 0xFF
  bne x2, x3, fail

  # Offset 29: Stored 0x7F (Max Signed Byte).
  # LB should be 0x0000007F
  lb x2, 29(x10)
  li x3, 0x7F
  bne x2, x3, fail


  # --- 4. Verify Endianness / Overlap Construction ---
  # We manually stored bytes 44, 33, 22, 11 at 32, 33, 34, 35.
  
  # Test A: Read back as a full WORD. Should be 0x11223344 (Little Endian)
  lw x2, 32(x10)
  li x3, 0x11223344
  bne x2, x3, fail

  # Test B: Read back middle Half-Word (Offset 33).
  # Bytes at 33 is 0x33, at 34 is 0x22.
  # Should form 0x2233
  lhu x2, 33(x10)   # Unaligned load check (if HW supports) OR just byte check
  # Note: Standard RV32E hardware might trap on unaligned loads. 
  # If your HW supports unaligned, uncomment below. 
  # If strictly aligned, we skip to aligned check.
  
  # Aligned Check: Read Half at 34 (Bytes 0x22, 0x11) -> 0x1122
  lhu x2, 34(x10)
  li  x3, 0x1122
  bne x2, x3, fail

# ==============================================================================
# FINAL SUCCESS TRAP
# ==============================================================================
pass:
  j pass

# ==============================================================================
# FAILURE TRAP
# ==============================================================================
fail:
  j fail