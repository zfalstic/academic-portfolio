;;***********************************************************
; Programming Assignment 3
; Student Name: Dawson Zhang
; UT Eid: ddz249
; Simba in the Jungle
; This is the starter code. You are given the main program
; and some declarations. The subroutines you are responsible for
; are given as empty stubs at the bottom. Follow the contract. 
; You are free to rearrange your subroutines if the need were to 
; arise.
; Note: Remember "Callee-Saves" (Cleans its own mess)

;***********************************************************

.ORIG x4000

;***********************************************************
; Main Program
;***********************************************************
    JSR   DISPLAY_JUNGLE
    LEA   R0, JUNGLE_INITIAL
    TRAP  x22 
    LDI   R0, BLOCKS
    JSR   LOAD_JUNGLE
    JSR   DISPLAY_JUNGLE
    LEA   R0, JUNGLE_LOADED
    TRAP  x22                        ; output end message
    TRAP  x25                        ; halt
JUNGLE_LOADED       .STRINGZ "\nJungle Loaded\n"
JUNGLE_INITIAL      .STRINGZ "\nJungle Initial\n"
BLOCKS          .FILL x5500

;***********************************************************
; Global constants used in program
;***********************************************************
;***********************************************************
; This is the data structure for the Jungle grid
;***********************************************************
GRID .STRINGZ "+-+-+-+-+-+-+-+-+"
     .STRINGZ "| | | | | | | | |"
     .STRINGZ "+-+-+-+-+-+-+-+-+"
     .STRINGZ "| | | | | | | | |"
     .STRINGZ "+-+-+-+-+-+-+-+-+"
     .STRINGZ "| | | | | | | | |"
     .STRINGZ "+-+-+-+-+-+-+-+-+"
     .STRINGZ "| | | | | | | | |"
     .STRINGZ "+-+-+-+-+-+-+-+-+"
     .STRINGZ "| | | | | | | | |"
     .STRINGZ "+-+-+-+-+-+-+-+-+"
     .STRINGZ "| | | | | | | | |"
     .STRINGZ "+-+-+-+-+-+-+-+-+"
     .STRINGZ "| | | | | | | | |"
     .STRINGZ "+-+-+-+-+-+-+-+-+"
     .STRINGZ "| | | | | | | | |"
     .STRINGZ "+-+-+-+-+-+-+-+-+"
                   

;***********************************************************
; this data stores the state of current position of Simba and his Home
;***********************************************************
CURRENT_ROW        .BLKW   #1       ; row position of Simba
CURRENT_COL        .BLKW   #1       ; col position of Simba 
HOME_ROW           .BLKW   #1       ; Home coordinates (row and col)
HOME_COL           .BLKW   #1

;***********************************************************
;***********************************************************
;***********************************************************
;***********************************************************
;***********************************************************
;***********************************************************
; The code above is provided for you. 
; DO NOT MODIFY THE CODE ABOVE THIS LINE.
;***********************************************************
;***********************************************************
;***********************************************************
;***********************************************************
;***********************************************************
;***********************************************************
;***********************************************************

;***********************************************************
; DISPLAY_JUNGLE
;   Displays the current state of the Jungle Grid 
;   This can be called initially to display the un-populated jungle
;   OR after populating it, to indicate where Simba is (*), any 
;   Hyena's(#) are, and Simba's Home (H).
; Input: None
; Output: None
; Notes: The displayed grid must have the row and column numbers
;***********************************************************
DISPLAY_JUNGLE

    ST R0, SR_DJ_R0
    ST R1, SR_DJ_R1
    ST R2, SR_DJ_R2

    LD R1, DJ_GRID_ADDRESS
    LD R2, DJ_ROW_HEIGHT

    LEA R0, NEW_LINE
    TRAP x22
    LEA R0, COLUMN_NUMBERS
    TRAP x22
    LEA R0, GRID_BAR
    TRAP x22
    
    LEA R0, STARTING_0
    TRAP x22
    ADD R1, R1, R2
    ADD R0, R1, #0
    TRAP x22
    LEA R0, NEW_LINE
    TRAP x22
    LEA R0, GRID_BAR
    TRAP x22
    
    LEA R0, STARTING_1
    TRAP x22
    ADD R1, R1, R2
    ADD R1, R1, R2
    ADD R0, R1, #0
    TRAP x22
    LEA R0, NEW_LINE
    TRAP x22
    LEA R0, GRID_BAR
    TRAP x22
    
    LEA R0, STARTING_2
    TRAP x22
    ADD R1, R1, R2
    ADD R1, R1, R2
    ADD R0, R1, #0
    TRAP x22
    LEA R0, NEW_LINE
    TRAP x22
    LEA R0, GRID_BAR
    TRAP x22
    
    LEA R0, STARTING_3
    TRAP x22
    ADD R1, R1, R2
    ADD R1, R1, R2
    ADD R0, R1, #0
    TRAP x22
    LEA R0, NEW_LINE
    TRAP x22
    LEA R0, GRID_BAR
    TRAP x22
    
    LEA R0, STARTING_4
    TRAP x22
    ADD R1, R1, R2
    ADD R1, R1, R2
    ADD R0, R1, #0
    TRAP x22
    LEA R0, NEW_LINE
    TRAP x22
    LEA R0, GRID_BAR
    TRAP x22
    
    LEA R0, STARTING_5
    TRAP x22
    ADD R1, R1, R2
    ADD R1, R1, R2
    ADD R0, R1, #0
    TRAP x22
    LEA R0, NEW_LINE
    TRAP x22
    LEA R0, GRID_BAR
    TRAP x22
    
    LEA R0, STARTING_6
    TRAP x22
    ADD R1, R1, R2
    ADD R1, R1, R2
    ADD R0, R1, #0
    TRAP x22
    LEA R0, NEW_LINE
    TRAP x22
    LEA R0, GRID_BAR
    TRAP x22
    
    LEA R0, STARTING_7
    TRAP x22
    ADD R1, R1, R2
    ADD R1, R1, R2
    ADD R0, R1, #0
    TRAP x22
    LEA R0, NEW_LINE
    TRAP x22
    LEA R0, GRID_BAR
    TRAP x22
    
    LD R0, SR_DJ_R0
    LD R1, SR_DJ_R1
    LD R2, SR_DJ_R2

    JMP R7
    
SR_DJ_R0    .BLKW #1
SR_DJ_R1    .BLKW #1
SR_DJ_R2    .BLKW #1
    
DJ_ROW_HEIGHT   .FILL #18
DJ_GRID_ADDRESS .FILL GRID

COLUMN_NUMBERS  .STRINGZ "   0 1 2 3 4 5 6 7 \n"
GRID_BAR        .STRINGZ "  +-+-+-+-+-+-+-+-+\n"
NEW_LINE        .STRINGZ "\n"
STARTING_0      .STRINGZ "0 "
STARTING_1      .STRINGZ "1 "
STARTING_2      .STRINGZ "2 "
STARTING_3      .STRINGZ "3 "
STARTING_4      .STRINGZ "4 "
STARTING_5      .STRINGZ "5 "
STARTING_6      .STRINGZ "6 "
STARTING_7      .STRINGZ "7 "

;***********************************************************
; LOAD_JUNGLE
; Input:  R0  has the address of the head of a linked list of
;         gridblock records. Each record has four fields:
;       0. Address of the next gridblock in the list
;       1. row # (0-7)
;       2. col # (0-7)
;       3. Symbol (can be I->Initial,H->Home or #->Hyena)
;    The list is guaranteed to: 
;               * have only one Inital and one Home gridblock
;               * have zero or more gridboxes with Hyenas
;               * be terminated by a gridblock whose next address 
;                 field is a zero
; Output: None
;   This function loads the JUNGLE from a linked list by inserting 
;   the appropriate characters in boxes (I(*),#,H)
;   You must also change the contents of these
;   locations: 
;        1.  (CURRENT_ROW, CURRENT_COL) to hold the (row, col) 
;            numbers of Simba's Initial gridblock
;        2.  (HOME_ROW, HOME_COL) to hold the (row, col) 
;            numbers of the Home gridblock
;       
;***********************************************************
LOAD_JUNGLE

    ST R0, SR_LJ_R0
    ST R1, SR_LJ_R1
    ST R2, SR_LJ_R2
    ST R3, SR_LJ_R3
    ST R4, SR_LJ_R4
    ST R7, SR_LJ_R7

LJ_Loop1S
    ADD R0, R0, #0
    
    BRz LJ_Loop1E
    
    LDR R1, R0, #1
    LDR R2, R0, #2
    LDR R3, R0, #3
    
    LD R4, LJ_I
    ADD R4, R4, R3
    
    BRnp LJ_NotI
    
    LD R3, LJ_*
    
    ST R1, CURRENT_ROW
    ST R2, CURRENT_COL

LJ_NotI

    LD R4, LJ_H
    ADD R4, R4, R3
    
    BRnp LJ_NotH
    
    ST R1, HOME_ROW
    ST R2, HOME_COL

LJ_NotH
    
    ST R0, SR_LJ_R00
    
    JSR GRID_ADDRESS
    
    STR R3, R0, #0
    
    LD R0, SR_LJ_R00
    
    LDR R0, R0, #0
    BRnzp LJ_Loop1S
LJ_Loop1E

    LD R0, SR_LJ_R0
    LD R1, SR_LJ_R1
    LD R2, SR_LJ_R2
    LD R3, SR_LJ_R3
    LD R4, SR_LJ_R4
    LD R7, SR_LJ_R7

    JMP  R7
    
SR_LJ_R0    .BLKW #1
SR_LJ_R1    .BLKW #1
SR_LJ_R2    .BLKW #1
SR_LJ_R3    .BLKW #1
SR_LJ_R4    .BLKW #1
SR_LJ_R7    .BLKW #1

SR_LJ_R00   .BLKW #1

LJ_I    .FILL #-73
LJ_H    .FILL #-72
LJ_*    .FILL x2A

;***********************************************************
; GRID_ADDRESS
; Input:  R1 has the row number (0-7)
;         R2 has the column number (0-7)
; Output: R0 has the corresponding address of the space in the GRID
; Notes: This is a key routine.  It translates the (row, col) logical 
;        GRID coordinates of a gridblock to the physical address in 
;        the GRID memory.
;***********************************************************
GRID_ADDRESS

    ST R1, SR_GA_R1
    ST R2, SR_GA_R2
    ST R3, SR_GA_R3
    
    LD R0, GA_GRID_ADDRESS
    
    LD R3, GA_ROW_HEIGHT
    
    ADD R0, R0, R3
    
GA_Loop1S
    ADD R1, R1, #-1
    BRn GA_Loop1E
    
    ADD R0, R0, R3
    ADD R0, R0, R3
    
    BRnzp GA_Loop1S
GA_Loop1E

    ADD R0, R0, #1
    
GA_Loop2S
    ADD R2, R2, #-1
    BRn GA_Loop2E
    
    ADD R0, R0, #2
    
    BRnzp GA_Loop2S
GA_Loop2E

    LD R1, SR_GA_R1
    LD R2, SR_GA_R2
    LD R3, SR_GA_R3
 
    JMP R7
    
GA_ROW_HEIGHT   .FILL #18
GA_GRID_ADDRESS .FILL GRID
    
SR_GA_R1    .BLKW #1
SR_GA_R2    .BLKW #1
SR_GA_R3    .BLKW #1

          .END

; This section has the linked list for the
; Jungle's layout: #(0,1)->H(4,7)->I(2,1)->#(1,1)->#(6,3)->F(3,5)->F(4,4)->#(5,6)
	.ORIG	x5500
	.FILL	Head   ; Holds the address of the first record in the linked-list (Head)
blk2
	.FILL   blk4
	.FILL   #1
    .FILL   #1
	.FILL   x23

Head
	.FILL	blk1
    .FILL   #0
	.FILL   #1
	.FILL   x23

blk1
	.FILL   blk3
	.FILL   #4
	.FILL   #7
	.FILL   x48

blk3
	.FILL   blk2
	.FILL   #2
	.FILL   #1
	.FILL   x49

blk4
	.FILL   blk5
	.FILL   #6
	.FILL   #3
	.FILL   x23

blk7
	.FILL   #0
	.FILL   #5
	.FILL   #6
	.FILL   x23
blk6
	.FILL   blk7
	.FILL   #4
	.FILL   #4
	.FILL   x46
blk5
	.FILL   blk6
	.FILL   #3
	.FILL   #5
	.FILL   x46
	.END	

