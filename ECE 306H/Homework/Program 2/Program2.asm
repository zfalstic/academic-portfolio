; Programming Assignment 2
; Student Name: Dawson Zhang
; UT Eid: ddz249
; You are given an array of student records starting at location x3500.
; The array is terminated by a sentinel. Each student record in the array
; has two fields:
;      Score -  A value between 0 and 100
;      Address of Name  -  A value which is the address of a location in memory where
;                          this student's name is stored.
; The end of the array is indicated by the sentinel record whose Score is -1
; The array itself is unordered meaning that the student records dont follow
; any ordering by score or name.
; You are to perform two tasks:
; Task 1: Sort the array in decreasing order of Score. Highest score first.
; Task 2: You are given a name (string) at location x6100, You have to lookup this student 
;         in the Array (post Task1) and put the student's score at x60FF (i.e., in front of the name)
;         If the student is not in the list then a score of -1 must be written to x60FF
; Notes:
;       * If two students have the same score then keep their relative order as
;         in the original array.
;       * Names are case-sensitive.

	.ORIG	x3000
	
    LD R0, StudentRecords
    
    JSR StudentRecordsSort
    
    LD R1, LookupName
    
    JSR LookupScoreByName
    
    STR, R2, R1, #-1

	HALT

; FILLS

StudentRecords    .FILL x3500
LookupName        .FILL x6100
	
; SUBROUTINES

; Sorts a StudentRecords array located at R0 by decsending scores using insertion sort
; Input: R0 <- StudentRecords address
; Output: Sorted StudentRecords array at same address
StudentRecordsSort

    ST R7, SR_StudentRecordsSort_R7

    ST R0, SR_StudentRecordsSort_R0
    ST R1, SR_StudentRecordsSort_R1
    ST R2, SR_StudentRecordsSort_R2
    ST R3, SR_StudentRecordsSort_R3
    ST R4, SR_StudentRecordsSort_R4
    ST R5, SR_StudentRecordsSort_R5
    ST R6, SR_StudentRecordsSort_R6
    
    AND R5, R5, #0
    ADD R5, R5, R0
    
    LDR R6, R5, #0
    
    BRn EmptyArray
    
    ADD R5, R5, #2 ; skip the first index
    
Loop1S
    LDR R1, R5, #0 ; R1 <- StudentRecords[i].score

    BRn Loop1E
    
    AND R1, R1, #0
    ADD R1, R1, R5 ; R1 <- j
    
    AND R2, R2, #0
    ADD R2, R2, R5 ; R2 <- k
    
Loop2S
    ADD R1, R1, #-2 ; j = k - 1
    
    NOT R3, R1
    ADD R3, R3, #1
    ADD R3, R0, R3
    
    BRp Loop2E
    
    LDR R3, R1, #0 ; R3 <- StudentRecords[j].score
    LDR R4, R2, #0 ; R4 <- StudentRecords[k].score
    
    NOT R4, R4
    ADD R4, R4, #1
    ADD R4, R3, R4
    
    BRzp InOrder ; if StudentRecords[j].score < StudentRecords[k].score
    
    ST R0, SR_StudentRecordsSort_R00
    AND R0, R0, #0
    ADD R0, R0, R2
    
    JSR StudentRecordsSwap
    
    LD R0, SR_StudentRecordsSort_R00
    
InOrder
    
    ADD R2, R2, #-2
    
    BRnzp Loop2S
Loop2E

    ADD R5, R5, #2
    
    BRnzp Loop1S
Loop1E
EmptyArray

    LD R7, SR_StudentRecordsSort_R7

    LD R0, SR_StudentRecordsSort_R0
    LD R1, SR_StudentRecordsSort_R1
    LD R2, SR_StudentRecordsSort_R2
    LD R3, SR_StudentRecordsSort_R3
    LD R4, SR_StudentRecordsSort_R4
    LD R5, SR_StudentRecordsSort_R5
    LD R6, SR_StudentRecordsSort_R6

    RET

SR_StudentRecordsSort_R7    .BLKW #1 

SR_StudentRecordsSort_R0    .BLKW #1 ; (prev)
SR_StudentRecordsSort_R1    .BLKW #1 ; (prev)
SR_StudentRecordsSort_R2    .BLKW #1 ; (prev)
SR_StudentRecordsSort_R3    .BLKW #1 ; (prev)
SR_StudentRecordsSort_R4    .BLKW #1 ; (prev)
SR_StudentRecordsSort_R5    .BLKW #1 ; (prev)
SR_StudentRecordsSort_R6    .BLKW #1 ; (prev)

SR_StudentRecordsSort_R00   .BLKW #1 ; (curr)
    
; Swaps two elements at index R0 and R1 of a StudentRecords array
; Input: 
;   R0 <- StudentRecords swap index 1
;   R1 <- StudentRecords swap index 2
; Output: StudentRecords array at same address with elements at index R1 and R2 swapped
StudentRecordsSwap

    ST R0, SR_StudentRecordsSwap_R0
    ST R1, SR_StudentRecordsSwap_R1
    ST R2, SR_StudentRecordsSwap_R2
    ST R3, SR_StudentRecordsSwap_R3
    ST R4, SR_StudentRecordsSwap_R4
    ST R5, SR_StudentRecordsSwap_R5

    LDR R2, R0, #0
    LDR R3, R0, #1
    LDR R4, R1, #0
    LDR R5, R1, #1
    
    STR R4, R0, #0
    STR R5, R0, #1
    STR R2, R1, #0
    STR R3, R1, #1
    
    LD R0, SR_StudentRecordsSwap_R0
    LD R1, SR_StudentRecordsSwap_R1
    LD R2, SR_StudentRecordsSwap_R2
    LD R3, SR_StudentRecordsSwap_R3
    LD R4, SR_StudentRecordsSwap_R4
    LD R5, SR_StudentRecordsSwap_R5
    
    RET

SR_StudentRecordsSwap_R0    .BLKW #1
SR_StudentRecordsSwap_R1    .BLKW #1
SR_StudentRecordsSwap_R2    .BLKW #1
SR_StudentRecordsSwap_R3    .BLKW #1
SR_StudentRecordsSwap_R4    .BLKW #1
SR_StudentRecordsSwap_R5    .BLKW #1

; Searches a StudentRecords array at R0 for a corresponding name located at R1 and returns
; the score of the student
; Input: 
;   R0 <- StudentRecords address
;   R1 <- Name address
; Output:
;   Score of student R1 -> R2
LookupScoreByName

    ST R0, SR_LookupScoreByName_R0
    ST R1, SR_LookupScoreByName_R1
    
    ST R3, SR_LookupScoreByName_R3
    ST R4, SR_LookupScoreByName_R4
    ST R5, SR_LookupScoreByName_R5
    ST R6, SR_LookupScoreByName_R6

Search_Loop1S
    LDR R2, R0, #0
    
    BRn Search_Loop1E
    
    LDR R3, R0, #1
    
Search_Loop2S
    LDR R4, R3, #0
    
    Brnp NotSentinel1
    
    LDR R5, R1, #0
    
    Brnp NotSentinel2
    
    BRnzp BothReachSentinel
    
NotSentinel1
NotSentinel2

    LDR R5, R1, #0
    
    NOT R4, R4
    ADD R4, R4, #1
    ADD R4, R4, R5
    
    BRnp Search_Loop2E
    
    ADD R3, R3, #1
    ADD R1, R1, #1
    
    BRnzp Search_Loop2S
Search_Loop2E
    
    ADD R0, R0, #2
    
    BRnzp Search_Loop1S
Search_Loop1E
BothReachSentinel

    LD R0, SR_LookupScoreByName_R0
    LD R1, SR_LookupScoreByName_R1
    
    LD R3, SR_LookupScoreByName_R3
    LD R4, SR_LookupScoreByName_R4
    LD R5, SR_LookupScoreByName_R5
    LD R6, SR_LookupScoreByName_R6

    RET
    
SR_LookupScoreByName_R0     .BLKW #1
SR_LookupScoreByName_R1     .BLKW #1

SR_LookupScoreByName_R3     .BLKW #1
SR_LookupScoreByName_R4     .BLKW #1
SR_LookupScoreByName_R5     .BLKW #1
SR_LookupScoreByName_R6     .BLKW #1
    
    .END

; Student records are at x3500
    .ORIG	x3500
	.FILL   #-1
    .END

; Joe
	.ORIG	x4700
	.STRINGZ "Joe"
	.END
; Wow
	.ORIG	x4200
	.STRINGZ "Wonder Woman"
	.END
	
; Bat
	.ORIG	x4100
	.STRINGZ "Bat Man"
	.END
	
	.ORIG   x4300
	.STRINGZ "a"
	.END
	
	.ORIG   x4400
	.STRINGZ "b"
	.END
	
	.ORIG   x4500
	.STRINGZ "c"
	.END

; Person to Lookup	
	.ORIG   x6100
;       The following lookup should give score of 55
;	.STRINGZ  "Joe"
;       The following lookup should give score of 75
;	.STRINGZ  "Bat Man"
;       The following lookup should give score of -1 because Bat man is 
;           spelled with lowercase m; There is no student with that name 
	.STRINGZ  "c"
	.END
	
