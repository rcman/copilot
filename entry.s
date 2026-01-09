; entry.s - kernel entry, sets up stack and calls C kmain()
        .title "kernel entry"
        .globl _kmain
        .globl _kernel_entry

_kernel_entry:
        ; Set up stack pointer (example high RAM address)
        mov $0377000, sp    ; adjust to fit your chosen memory layout
        ; Call C entry point
        jsr pc, _kmain
halt_loop:
        br halt_loop
        .end
