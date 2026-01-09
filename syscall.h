#ifndef SYSCALL_H
#define SYSCALL_H

#include <stdint.h>

typedef uint16_t u16;

/* Context layout must match assembly context save/restore */
typedef struct {
    u16 r1, r2, r3, r4, r5, r6;
    u16 pc;
} context_t;

#endif
