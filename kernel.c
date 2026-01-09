/* kernel.c - kernel core in C
 * - kmain(): initializes tasks and enters idle loop
 * - create_task(): basic task creation (no separate address spaces yet)
 * - timer_entry(): called from vector/assembly on timer interrupt
 *
 * This file expects context_save/context_restore in assembly.
 */

#include <stdint.h>
#include <stddef.h>

#define MAX_TASKS 4
#define STACK_SIZE 512

typedef struct {
    uint16_t r1, r2, r3, r4, r5, r6;
    uint16_t pc;
} context_t;

typedef struct {
    context_t ctx;
    uint8_t stack[STACK_SIZE];
    int id;
    int runnable;
} task_t;

extern void context_save(context_t* ctx);
extern void context_restore(context_t* ctx);
extern void timer_acknowledge(void); /* optional: ack hardware timer */

static task_t tasks[MAX_TASKS];
static int task_count = 0;
static int current = -1;

void create_task(void (*fn)(void*), void* arg);
void task_wrapper(void);

void idle_task(void* arg) {
    for (;;) {
        /* halt until next interrupt */
        asm volatile("halt");
    }
}

void kmain(void) {
    /* basic init */
    for (int i = 0; i < MAX_TASKS; ++i) {
        tasks[i].runnable = 0;
        tasks[i].id = i;
    }

    /* create an idle task and one test task */
    create_task(idle_task, NULL);
    create_task(idle_task, NULL);

    /* set current to first task */
    current = 0;

    /* enable timer hardware here (not implemented) and loop */
    for (;;) {
        asm volatile("halt");
    }
}

/* Minimal create_task:
 * - place a fake context so context_restore can jump into the function.
 * - we place the function address into ctx.pc and set runnable.
 *
 * Note: This is a simplified approach for early testing. Later you will need a stack
 * frame setup consistent with the ABI and possibly to push an initial PSW.
 */
void create_task(void (*fn)(void*), void* arg) {
    if (task_count >= MAX_TASKS) return;
    task_t* t = &tasks[task_count];
    /* initialize stack & context: point PC to function */
    t->ctx.pc = (uint16_t)((uintptr_t)fn & 0xFFFF);
    t->runnable = 1;
    task_count++;
}

/* Called from timer vector (assembly) */
void timer_entry(void) {
    /* ACK the timer if needed */
    timer_acknowledge();

    if (task_count <= 1) return;

    /* Save current context */
    if (current >= 0) {
        context_save(&tasks[current].ctx);
    }

    /* simple round-robin selection */
    int next = (current + 1) % task_count;
    current = next;

    /* restore next context (this will not return here) */
    context_restore(&tasks[current].ctx);
}

/* weak stub to satisfy link if not implemented */
void timer_acknowledge(void) {
    /* platform-specific timer ack; for SIMH you may not need this */
    return;
}

/* Provide C entry symbol expected by assembly */
void _kmain(void) __attribute__((alias("kmain")));
