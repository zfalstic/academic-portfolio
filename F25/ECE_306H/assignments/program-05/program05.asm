; Program5.asm
; Name(s): Nathan Aaker, Dawson Zhang
; UTEid(s): nxa65, ddz249
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
LD R1, KBINTEN
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
    TRAP x21
    AND R0, R0, #0
    STI R0, GLOB
    LD R1, CurrentState
    LDI R0, GLOB2
    ADD R1, R1, R0
    LDR R2, R1, #0 ;Has next state
    BRz StopDetected
    LDR R0, R2, #0 ;Output for next state
    BRz NoOutput
    TRAP x21
NoOutput
    ST R2, CurrentState
    BR Loop
StopDetected
; Repeat until Stop Codon detected
    HALT
KBINTVec  .FILL x0180
KBSR   .FILL xFE00
KBISR  .FILL x2500
KBINTEN  .FILL x4000
GLOB   .FILL x3500
GLOB2   .FILL x3501

CurrentState    .FILL Start
Start   .FILL x00
        .FILL StartA
        .FILL Start
        .FILL Start
        .FILL Start
StartA  .FILL x00
        .FILL StartA
        .FILL Start
        .FILL StartAU
        .FILL Start
StartAU .FILL x00
        .FILL Start
        .FILL Start
        .FILL Start
        .FILL StartAUG
StartAUG
        .FILL x7c
        .FILL RepeatRNA
        .FILL RepeatRNA
        .FILL StopU
        .FILL RepeatRNA
RepeatRNA
        .FILL x00
        .FILL RepeatRNA
        .FILL RepeatRNA
        .FILL StopU
        .FILL RepeatRNA
StopU   .FILL x00
        .FILL StopUA
        .FILL RepeatRNA
        .FILL StopU
        .FILL StopUG
StopUA  .FILL x00
        .FILL #0
        .FILL RepeatRNA
        .FILL StopU
        .FILL #0
StopUG  .FILL x00
        .FILL #0
        .FILL RepeatRNA
        .FILL StopU
        .FILL RepeatRNA
	.END

; Interrupt Service Routine
; Keyboard ISR runs when a key is struck
; Checks for a valid RNA symbol and places it at x3500
        .ORIG x2500
        ST R0, ISR_R0
        ST R1, ISR_R1
        
        LDI R0, KBDR
        LD R1, KBDRMask
        AND R0, R0, R1
        
        LD R1, -A
        ADD R1, R0, R1
        BRnp NotA
        AND R1, R1 #0
        ADD R1, R1, #1
        STI R1, IGLOB2
        STI R0, IGLOB
        BRnzp Return
NotA
        
        LD R1, -C
        ADD R1, R0, R1
        BRnp NotC
        AND R1, R1 #0
        ADD R1, R1, #2
        STI R1, IGLOB2
        STI R0, IGLOB
        BRnzp Return
NotC
        
        LD R1, -U
        ADD R1, R0, R1
        BRnp NotU
        AND R1, R1 #0
        ADD R1, R1, #3
        STI R1, IGLOB2
        STI R0, IGLOB
        BRnzp Return
NotU
        
        LD R1, -G
        ADD R1, R0, R1
        BRnp Return
        AND R1, R1 #0
        ADD R1, R1, #4
        STI R1, IGLOB2
        STI R0, IGLOB
Return

        LD R0, ISR_R0
        LD R1, ISR_R1
        
        RTI
        
ISR_R0  .BLKW #1
ISR_R1  .BLKW #1
KBDR  .FILL xFE02
KBDRMask .FILL x00FF
IGLOB  .FILL x3500
IGLOB2  .FILL x3501
-A  .FILL #-65
-C  .FILL #-67
-U  .FILL #-85
-G  .FILL #-71

		.END
