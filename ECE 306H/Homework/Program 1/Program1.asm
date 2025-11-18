; Programming Project 1 starter file
; Student Name: Dawson Zhang
; UTEid: ddz249
; Modify this code to satisfy the requirements of Program 1
; Compute N^M, where N and M are non-negative inputs to your program.
; The input numbers are given to you in memory locations x3500 (N) and x3501 (M) 
; The computed result has to be placed in x3502 (N2theM). 
; If the computation of the value of NM exceeds x7FFF then you put the 
; value -1 at x3502. Assume 0^0 = 0.
; Read the complete Project Description on the Google doc linked
    .ORIG x3000
;---- Your Solution goes here	

; R3 <- x3500
    LD R3, Data

; R2 <- 0
    AND R2, R2, #0
    
; R0 <- N
    LDR R0, R3, #0
    
; R2 <- 1 ONLY if N is NOT 0
    BRz Break
    ADD R2, R2, #1

; R1 <- M
    LDR R1, R3, #1

; For M > 0, M <- M - 1
More1
    BRnz MisntP

; R4 <- R2
    AND R4, R4, #0
    ADD R4, R4, R2

; R5 <- R0 - 1
    AND R5, R5, #0
    ADD R5, R5, R0
    ADD R5, R5, #-1
    
; For R5 > 0, R5 <- R5 - 1
More2
    BRnz NisntP
    
; R2 <- R2 + R4
    ADD R2, R2, R4
    
; If R2 <= 0
    BRp NotOverflow
    
; R2 <- -1
    AND R2, R2, #0
    ADD R2, R2, #-1
    
    BRnzp Break
    
NotOverflow

    ADD R5, R5, #-1
    BRnzp More2
NisntP

    ADD R1, R1, #-1
    BRnzp More1
MisntP
Break

; R2 -> N2theM
    STR R2, R3, #2

;---- Done
	HALT
;---- You may declare your stuff here if needed    

; Data pointer
Data    .FILL x3500

    .END
    
;---- Data: Inputs and Output go here
    .ORIG x3500
;N    .FILL x0003
;M    .FILL x0002
;N    .FILL x000A
;M    .FILL x000A
N    .FILL x0000
M    .FILL x0000
;N    .FILL x00B2
;M    .FILL x0002
;N    .FILL x7FFF
;M    .FILL x0001
N2theM  .BLKW #1
    .END