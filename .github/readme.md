
```markdown
# PDP-11/45 Minimal Kernel (C + C++ starter)

Target
- PDP-11/45 (MMU-equipped)
- Test: SIMH PDP-11 emulator
- Kernel core: C
- Small C++ helpers: limited features (no exceptions, no RTTI, avoid stdlib)

What this tree provides
- Minimal boot and entry sequence (MACRO-11-style assembly)
- Vector placeholders and timer IRQ hook
- Context save/restore primitives (assembly)
- Kernel core in C: kmain, basic task structure, create_task, timer IRQ -> scheduler
- Tiny C++ utility (callable from C) for simple logging/formatting
- Linker script and Makefile outline (you must point to an available PDP-11 cross-toolchain)

Build notes
- PDP-11 cross-toolchains are uncommon; this Makefile uses placeholders:
  - AS = pdp11-as (assembler)
  - CC = pdp11-gcc or pdp11-gcc-like (C compiler)
  - LD = pdp11-ld (linker)
- If you do not have a native cross-toolchain, I can:
  - Suggest and target a specific vintage toolchain (PCC/mac or others), or
  - Produce assembly-only artifacts convertible to SIMH memory load commands.

SIMH
- Use `simh pdp11` and load the produced flat binary or use SIMH load/attach commands.
- The README and simh.ini contain quick notes; I can produce a tested SIMH command sequence if you want a runnable image.

Next steps I can do after you confirm:
- Produce the files and attempt to build a SIMH-ready kernel.bin (pick a toolchain or let me pick one).
- Implement MMU initialization and a per-process mapping example for PDP-11/45.
- Implement a simple disk loader to boot from simulated RK/RL disk images in SIMH.

```
