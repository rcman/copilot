; boot.s - minimal boot stub for early testing
; Assemble/link so it loads at a known address (see linker script)
        .title   "boot stub"
        .org     0000400o    ; example boot block origin (adjust via linker)

_start:
        ; Clear registers (optional)
        clrb    r0
        clrb    r1
        mov     $001000, r0   ; kernel physical start address (example 0x1000)
        jmp     (r0)          ; jump to kernel entry
        .end _start
