# Makefile - outline. Replace tool placeholders with your PDP-11 toolchain commands.
AS = pdp11-as      # assembler
CC = pdp11-gcc     # C compiler (if available)
CXX = pdp11-g++    # C++ compiler (if available)
LD = pdp11-ld
OBJCOPY = pdp11-objcopy

CFLAGS = -nostdlib -ffreestanding -fno-exceptions -fno-rtti -O2
LDFLAGS = -T linker.ld

OBJS = boot.o vectors.o entry.o context.o kernel.o kernel_util.o

all: kernel.bin

boot.o: boot.s
	$(AS) -o $@ boot.s

vectors.o: vectors.s
	$(AS) -o $@ vectors.s

entry.o: entry.s
	$(AS) -o $@ entry.s

context.o: context.s
	$(AS) -o $@ context.s

kernel.o: kernel.c
	$(CC) $(CFLAGS) -c -o $@ kernel.c

kernel_util.o: kernel_util.cpp
	$(CXX) $(CFLAGS) -c -o $@ kernel_util.cpp

kernel.elf: $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $(OBJS)

kernel.bin: kernel.elf
	$(OBJCOPY) -O binary kernel.elf kernel.bin

clean:
	rm -f *.o kernel.elf kernel.bin

.PHONY: all clean
