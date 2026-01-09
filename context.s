; context.s - save + restore registers for context switching
; Simple layout: store r1..r6 and r7 (pc). Adjust as needed to match C struct alignment.
        .title "context primitives"

        .globl context_save
context_save:
        ; r0 = pointer to context struct
        mov r1, (r0)+
        mov r2, (r0)+
        mov r3, (r0)+
        mov r4, (r0)+
        mov r5, (r0)+
        mov r6, (r0)+
        mov r7, (r0)+
        rts pc

        .globl context_restore
context_restore:
        ; r0 = pointer to context struct
        mov -(r0), r7
        mov -(r0), r6
        mov -(r0), r5
        mov -(r0), r4
        mov -(r0), r3
        mov -(r0), r2
        mov -(r0), r1
        rti   ; return from interrupt to restore PSW too, if called in IRQ context

        .end
