; Quiz 8 Starter File
; Fill the following information before you start coding
; Student Name: Dawson Zhang
; UT Eid: ddz249
; This quiz requires you to solve two problems
; Description of the problems are in comments below
    .ORIG x3000
;=========================================
; Problem Statement 1:
;    You are given two inputs,  A, B stored at memory locations x3020 and x3021. 
;    Compute C = NOT(A) OR B and store it at x3022.
; Write your solution here:
;*********Start of Solution to Problem 1 **********

LD R0, A
LD R1, B

AND R1, R1, R1
NOT R1, R1

AND R0, R1, R0
NOT R0, R0

ST R0, C

;*********End of Solution to Problem 1 **********
;=========================================
; Problem Statement 2:
;    You are given two inputs,  N, D stored at memory locations x3025 and x3026. 
;    Compute Q, which is the quotient when N is divided by D and store it at x3027
;    You may assume that N>=0 and D>0
; Write your solution here:
;*********Start of Solution to Problem 2 **********

AND R0, R0, #0

LD R1, N
LD R2, D

NOT R2, R2
ADD R2, R2, #1

Loop1S
ADD R1, R1, R2

BRn Loop1E

ADD R0, R0, #1

BRnzp Loop1S
Loop1E

ST R0, Q

;*********End of Solution to Problem 1 **********
    HALT
; Add any needes  declarations here
    
    .END
;==============Inputs and Outputs are Below ==============
    .ORIG x3020
A   .FILL x4221
B   .FILL xABAA ; C should be xBFFE after your solution runs
;A  .FILL xFFFF
;B  .FILL x0000 ; C should be x0000 after your solution runs
;A  .FILL x1234
;B  .FILL xFFFF ; C should be xFFFF after your solution runs
C   .BLKW #1    
                ; Change A, B and test for different inputs
    .END

    .ORIG x3025
N   .FILL #42
D   .FILL #8    ; Q should be 5 after your solution runs
;N  .FILL #4    
;D  .FILL #3    ; Q should be 1 after your solution runs
;N  .FILL #2    
;D  .FILL #3    ; Q should be 0 after your solution runs
Q   .BLKW #1    
                ; Change N, D and test for different inputs
    .END
    









