; vectors.s - simple vector table (word entries pointing to handlers)
; Place vector table at appropriate vector region (PDP-11 vectors start at high addresses).
; This is a placeholder; you will map or place these per your memory layout.

        .title "vector table"
        .org 0000040o   ; vector region (example)
        ; Each .word holds the handler address for the corresponding vector
timer_vector:
        .word _timer_vector_stub
console_vector:
        .word _console_vector_stub
; Provide stubs for each referenced symbol
        .org 0002000o    ; place stubs somewhere reachable
_timer_vector_stub:
        jmp _timer_entry
_console_vector_stub:
        jmp _console_entry
        .end
