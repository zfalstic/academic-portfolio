;;;*************Exam2: ECE306H Fall 2025 ************
; Student Name: Dawson Zhang
; Student UTEID: ddz249
; There are two tasks in this Exam.
    .ORIG x3000
;;************* Task1: Logic+Masking ************
;; Task1: Logic+Masking Problem
;  Given two numbers A and B at x3080 and x3081
;  Compute C = (00000000Low_Byte(A) OR  00000000Low_Byte(B)) 
;                                   OR
;             (High_Byte(A)00000000 AND High_Byte(B)00000000);
;  Store C at x3082
;+++++++ Write solution for your Task 1 here +++++++

LD R0, A
LD R1, B
LD R2, HighMask
LD R3, LowMask

AND R4, R0, R3
AND R5, R1, R3

NOT R4, R4
NOT R5, R5
AND R4, R4, R5
NOT R4, R4

AND R0, R0, R2
AND R1, R1, R2

AND R0, R0, R1

NOT R4, R4
NOT R0, R0
AND R0, R0, R4
NOT R0, R0

ST R0, C

AND R0, R0, #0
AND R1, R1, #0
AND R2, R2, #0
AND R3, R3, #0
AND R4, R4, #0

;;*************Task2: Make Number from Digits ************
;; Task2: Array Problem
;  Description: 
; Given an array of Digits, compute the Number they form
; The length of the array of digits is between 1 and 5.
;  => which implies that there is at least one digit but less than 6 
; The array is terminated by a sentinel value of -1
; See Examples below
; The Digits array is at x4000 and the computed Number that the array
; represents must be written at x3FFF
; Note: Valid positive 16-bit numbers are less than 32768, so if the
; computed Number is not valid then you must write a -1 at x3FFF
;+++++++ Write solution for your Task 2 here +++++++

LD R0, ArrayPtr
AND R6, R6, #0

; Add in first value
LDR R2, R0, #0
ADD R1, R1, R2

Loop1S
ADD R0, R0, #1
LDR R2, R0, #0
BRn Loop1E

JSR MultiplyBy10

ADD R1, R1, R2

BRnzp Loop1S
Loop1E

ADD R1, R1, #0
BRzp NotOverflow3

AND R7, R7, #0
ADD R1, R6, #-1

NotOverflow3
ADD R6, R6, #0
BRzp NotOverflow

AND R6, R6, #0
ADD R1, R6, #-1

NotOverflow

LD R0, ResultPtr
STR R1, R0, #0

    HALT
    
MultiplyBy10
ADD R3, R3, #10
ADD R4, R1, #0

Loop2S
ADD R3, R3, #-1
BRz Loop2E

ADD R1, R1, R4

BRzp NotOverflow2

ADD R6, R6, #-1

NotOverflow2

BRnzp Loop2S
Loop2E

RET

;;++++++++  Declare your own variables/constants/masks here  ++++++++
;;++++++++ Also, add subroutines here if you choose to +++++++
HighMask    .FILL xFF00
LowMask     .FILL x00FF

ArrayPtr    .FILL x4000
ResultPtr   .FILL x3FFF
    .END


;;************** Data for Task1 ************
    .ORIG x3080
A   .FILL xABCD
B   .FILL x1234
C   .BLKW #1     ; Must be x02FD when Task1 completes
                 ;   (x00CD OR x0034) AND (xAB00 AND x1200)
                 ; =       x00FD      OR       x0200        = x02FD
;;++++++++ Write your own test cases to try ++++++++

    .END
    
;;************** Data for Task2 ************   
    .ORIG x3FFF
;Number  .BLKW #1    ; Must hold 403 when Task2 completes for test case below
;Digits  .FILL #4
;        .FILL #0
;        .FILL #3
;        .FILL #-1
Number  .BLKW #1    ; Must hold -1 when Task2 completes for test case below
Digits  .FILL #6
        .FILL #5
        .FILL #5
        .FILL #3
        .FILL #6
        .FILL #-1
;;++++++++ Write your own test cases to try ++++++++
    .END