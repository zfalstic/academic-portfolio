.section .vectors, "x"
.global _vectors

_vectors:
  B Reset_Handler /* Reset */
  B . /* Undefined */
  B . /* SWI */
  B . /* Prefetch Abort */
  B . /* Data Abort */
  B . /* reserved */
  B . /* IRQ */
  B . /* FIQ */

yOSHi:	.string  "\t === Virtual ARM Starting  === \n \t \t--- Running yOS --- \n"
	.balign 4
yOSBye:	.string  "\n \n \t=== Virtual ARM Halted ===\n"
	.balign 4

Reset_Handler:
	ldr sp, =stack_top
	ldr r0, =yOSHi
	bl  puts
	bl SystemInit
  	bl main
	ldr r0, =yOSBye
	bl  puts
  	b .

  .weak SystemInit
SystemInit:
// This is the launch of OS
    push {r0-r4,lr}
// Code for launch goes here:
// Put intialized globals in RAM (src: https://metebalci.com/blog/demystifying-arm-cortex-m33-bare-metal-startup/)
        ldr r0, =_sdata
        ldr r1, =_edata
        ldr r2, =_sidata
        movs r3, #0
        b LoopCopyDataInit
CopyDataInit:
        ldr r4, [r2, r3]
        str r4, [r0, r3]
        adds r3, #4
LoopCopyDataInit:
        adds r4, r0, r3
        cmp r4, r1
        bcc CopyDataInit

    pop {r0-r4,pc}



	
