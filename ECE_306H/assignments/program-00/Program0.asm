; Programming Assignment 0
; Student Name: Dawson Zhang
; UT Eid: ddz249
; You are given three inputs A, B and C stored respectively at addresses, 
;    x30F0, x30F1 and x30F2. 
; Your job is to perform the following operations and store the results at address specified:
; X = A OR B               (store X at x30F4)
; Y = A XOR B              (store Y at x30F5)
; Z = NOT(A OR B OR C)     (store Z at x30F6)
; W = NOT(A) AND NOT(B) AND NOT(C) (store W at x30F7)
; Sum = A + B + C          (store Sum at x30F8)
; Diff= A - B - C          (store Diff at x30f9) 

	.ORIG	x3000
; Your code goes here

; Load A B C into R0 R1 R2
    LD R0, xEF
    LD R1, XEF
    LD R2, XEF
    
; Compute X = A OR B
    NOT R3, R0
    NOT R4, R1
    AND R5, R3, R4
    NOT R5, R5
    
    ST R5, xEC

; Compute Y = A XOR B
    NOT R3, R0
    NOT R4, R1
    AND R5, R3, R1
    NOT R5, R5
    AND R6, R0, R4
    NOT R6, R6
    AND R7, R5, R6
    NOT R7, R7
    
    ST R7, xE4

; Compute Z = NOT(A OR B OR C)
    NOT R3, R0
    NOT R4, R1
    NOT R5, R2
    AND R6, R3, R4
    AND R6, R6, R5
    
    ST R6, xDF
    
; Compute W = NOT(A) AND NOT(B) AND NOT(C)
; Notice that W and Z are the same
    ST R6, XDF
    
; Compute Sum = A + B + C
    ADD R3, R0, R1
    ADD R3, R3, R2
    
    ST R3, xDD
    
; Compute Diff = A - B - C
    NOT R3, R1
    ADD R3, R3, #1
    NOT R4, R2
    ADD R4, R4, #1
    ADD R5, R0, R3
    ADD R5, R5, R4
    
    ST R5, xD7

	HALT
	.END