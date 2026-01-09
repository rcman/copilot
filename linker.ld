/* linker.ld - example PDP-11 linker script (conceptual)
 * You will need to adapt this to the specific PDP-11 linker format of your toolchain.
 * Place code at 0x1000 (example).
 */
SECTIONS
{
  . = 0x1000;
  .text : { *(.text) }
  .data : { *(.data) }
  .bss  : { *(.bss) }
}
