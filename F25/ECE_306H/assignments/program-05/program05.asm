; Program5.asm
; Name(s):
; UTEid(s): 
; Continuously reads from x3500 making sure its not reading duplicate
; symbols. Processes the symbol based on the program description
; of mRNA processing.
    .ORIG x3000
; set up the keyboard interrupt vector table entry
;M[x0180] <- x2500
LD R0, KBISR
STI R0, KBINTVec

; enable keyboard interrupts
; KBSR[14] <- 1 ==== M[xFE00] = x4000
LDI R0, KBSR
LD R1, KBIEN
NOT R0, R0
NOT R1, R1
AND R0, R0, R1
NOT R0, R0
STI R0, KBSR

; This loop is the proper way to read an input
Loop
    LDI R0, GLOB
    BRz Loop             
; Process it

; Repeat until Stop Codon detected
    HALT
KBINTVec  .FILL x0180
KBSR   .FILL xFE00
KBIEN   .FILL x4000
KBISR  .FILL x2500
KBINTEN  .FILL x4000
GLOB   .FILL x3500

	.END

; Interrupt Service Routine
; Keyboard ISR runs when a key is struck
; Checks for a valid RNA symbol and places it at x3500
        .ORIG x2500
        
        LDI R0, KBDR
        LD R1, KBDRMask
        AND R0, R0, R1
        
        LD R1, -A
        ADD R1, R0, R1
        BRz isValid
        
        LD R1, -C
        ADD R1, R0, R1
        BRz isValid
        
        LD R1, -U
        ADD R1, R0, R1
        BRz isValid
        
        LD R1, -G
        ADD R1, R0, R1
        BRz isValid
        
        BRnzp return
        
isValid
        STI R0, IGLOB
        
return
 
        RTI
        
KBDR  .FILL xFE02
KBDRMask .FILL x00FF
IGLOB  .FILL x3500
-A  .FILL #-65
-C  .FILL #-67
-U  .FILL #-85
-G  .FILL #-71

		.END
