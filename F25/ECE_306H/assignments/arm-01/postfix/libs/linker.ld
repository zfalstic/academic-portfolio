MEMORY
{
  PSRAM (rwx) : ORIGIN = 0x40000000, LENGTH = 32K
  ROM (rx)    : ORIGIN = 0x00000000, LENGTH = 128K
}

SECTIONS
{
  . = 0x00000000;
  .text :
  {
      *(.vectors)
      *(.text)
      *(.rodata)
  } >ROM
  .  = 0x40000000;
  _sidata = LOADADDR(.data);
  .data :
  {
      _sdata = .;
      *(.data)
      _edata = .;
  } >PSRAM AT > ROM
  .bss :
  {
      *(.bss)
  } >PSRAM AT > ROM
  stack_top = 0x40001000;

}
