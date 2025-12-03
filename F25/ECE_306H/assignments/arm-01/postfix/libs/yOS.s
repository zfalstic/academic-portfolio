/*
----------------------------------------------------------------------
File    : yOS.s
Purpose : Software Interrupt - System Call Handler implements yOS
Does:
          Makes these services available
                 svc 1: putc (r0 as char to output)
                 svc 2: getc (r0 returns char input)
                 svc 3: puts (r0 has address of a null-terminated string)
 Notes:
        0. All calls to svc in user code must be prefixed by this statement:
             .align 4
           This makes sure that the access to the stacked PC is valid (hardfault otherwise)

------------- END-OF-HEADER ------------------------------------------
*/
	.global putc
	.global getc
	.global puts
        .type   putc, function
        .type   getc, function
        .type   puts, function	


/*********************************************************************
*
*     CODE segment
*
**********************************************************************
*/
        .syntax unified
        .thumb
        .balign 4
        .text

	.equ  UART_DR, 0x09000000   // UART data register
	.equ  UART_FR, 0x09000018   // UART flags register
	.equ  UART_TXFF, 0x20       // Bit 5 Transmit FIFO Full
	.equ  UART_RXFE, 0x10       // Bit 4 Receive FIFO Empty
	
        .balign 4
/*********************************************************************
*     getc: Get a Char return in r0 
*/
getc:
	push {r4-r6, LR}
getcLoop:	
        ldr  r4,=UART_FR
        ldr  r5,[r4]
	movs r6, #UART_RXFE
	ands r5, r6
        bne  getcLoop    // Loop till char arrives
        ldr  r4,=UART_DR
        ldr  r0,[r4]
        ldr  r5,=0x00FF
        ands r0,r5
	pop  {r4-r6, PC}
/*
*     putc: Output a Char  given in r0 
*/
putc:
	push {r4-r6,LR}
putcLoop:
	ldr  r4,=UART_FR
        ldr  r5,[r4]
	movs r6, #UART_TXFF
	ands r5, r6
        bne  putcLoop    // Loop till TXD is ready
        ldr  r4,=UART_DR
        ldr  r5,=0x00FF
        ands r0,r5
        cmp  r0, #13
        bne  notCR
        movs r0, #10
notCR:	
        str  r0,[r4]    
       	pop  {r4-r6,PC}

/*
*     puts: Output a (null-terminated) stringwhose address is in r0 
*/
	
puts:
	push {r0, r4-r7,LR}
putsLoop:	
        ldrb r6,[r0]      // get the first(next) char
        cmp  r6,#0
        beq  putsDone
putsWait:
        ldr  r4,=UART_FR
        ldr  r5,[r4]
	movs r7, #UART_TXFF
	ands r5, r7
        bne  putsWait    // Loop till TXD is ready
        ldr  r4,=UART_DR
        ldr  r5,=0x00FF
	ands r6,r5
        cmp  r6, #13
        bne  notCR2
        movs r6, #10
notCR2:	
        str  r6,[r4]    
        adds r0,#1       // point to next char    
        b    putsLoop
putsDone:
	pop {r0, r4-r7,PC}
        .end
/****** End Of File *************************************************/
