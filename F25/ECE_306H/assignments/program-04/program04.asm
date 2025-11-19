;***********************************************************
; Programming Assignment 4
; Student Name: Dawson Zhang
; UT Eid: ddz249
; -------------------Save Simba (Part II)---------------------
; This is the starter code. You are given the main program
; and some declarations. The subroutines you are responsible for
; are given as empty stubs at the bottom. Follow the contract. 
; You are free to rearrange your subroutines if the need were to 
; arise.

;***********************************************************

.ORIG x4000

;***********************************************************
; Main Program
;***********************************************************
        JSR   DISPLAY_JUNGLE
        LEA   R0, JUNGLE_INITIAL
        TRAP  x22 
        LDI   R0,BLOCKS
        JSR   LOAD_JUNGLE
        JSR   DISPLAY_JUNGLE
        LEA   R0, JUNGLE_LOADED
        TRAP  x22                        ; output end message
HOMEBOUND
        LEA   R0, LC_OUT_STRING
        TRAP  x22
        LDI   R0,LC_LOC
        LD    R4,ASCII_OFFSET_POS
        ADD   R0, R0, R4
        TRAP  x21
        LEA   R0,PROMPT
        TRAP  x22
        TRAP  x20                        ; get a character from keyboard into R0
        TRAP  x21                        ; echo character entered
        LD    R3, ASCII_Q_COMPLEMENT     ; load the 2's complement of ASCII 'Q'
        ADD   R3, R0, R3                 ; compare the first character with 'Q'
        BRz   EXIT                       ; if input was 'Q', exit
;; call a converter to convert i,j,k,l to up(0) left(1),down(2),right(3) respectively
        JSR   IS_INPUT_VALID      
        ADD   R2, R2, #0                 ; R2 will be zero if the move was valid
        BRz   VALID_INPUT
        LEA   R0, INVALID_MOVE_STRING    ; if the input was invalid, output corresponding
        TRAP  x22                        ; message and go back to prompt
        BRnzp    HOMEBOUND
VALID_INPUT                 
        JSR   APPLY_MOVE                 ; apply the move (Input in R0)
        JSR   DISPLAY_JUNGLE
        JSR   SIMBA_STATUS      
        ADD   R2, R2, #0                 ; R2 will be zero if reached Home or -1 if Dead
        BRp  HOMEBOUND                     ; otherwise, loop back
EXIT   
        LEA   R0, GOODBYE_STRING
        TRAP  x22                        ; output a goodbye message
        TRAP  x25                        ; halt
JUNGLE_LOADED       .STRINGZ "\nJungle Loaded\n"
JUNGLE_INITIAL      .STRINGZ "\nJungle Initial\n"
ASCII_Q_COMPLEMENT  .FILL    x-71    ; two's complement of ASCII code for 'q'
ASCII_OFFSET_POS        .FILL    x30
LC_OUT_STRING    .STRINGZ "\n LIFE_COUNT is "
LC_LOC  .FILL LIFE_COUNT
PROMPT .STRINGZ "\nEnter Move up(i) \n left(j),down(k),right(l): "
INVALID_MOVE_STRING .STRINGZ "\nInvalid Input (ijkl)\n"
GOODBYE_STRING      .STRINGZ "\n!Goodbye!\n"
BLOCKS               .FILL x5500

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
LIFE_COUNT         .FILL   #1       ; Initial Life Count is One
                                    ; Count increases when Simba
                                    ; meets a Friend; decreases
                                    ; when Simba meets a Hyena
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
;   Friends (F) and Hyenas(#) are, and Simba's Home (H).
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
    LEA R0, GRID_BAR_START
    TRAP x22
    ADD R1, R1, R2
    ADD R0, R1, #0
    TRAP x22
    LEA R0, NEW_LINE
    TRAP x22
    
    LEA R0, STARTING_1
    TRAP x22
    ADD R1, R1, R2
    ADD R0, R1, #0
    TRAP x22
    LEA R0, NEW_LINE
    TRAP x22
    LEA R0, GRID_BAR_START
    TRAP x22
    ADD R1, R1, R2
    ADD R0, R1, #0
    TRAP x22
    LEA R0, NEW_LINE
    TRAP x22
    
    LEA R0, STARTING_2
    TRAP x22
    ADD R1, R1, R2
    ADD R0, R1, #0
    TRAP x22
    LEA R0, NEW_LINE
    TRAP x22
    LEA R0, GRID_BAR_START
    TRAP x22
    ADD R1, R1, R2
    ADD R0, R1, #0
    TRAP x22
    LEA R0, NEW_LINE
    TRAP x22
    
    LEA R0, STARTING_3
    TRAP x22
    ADD R1, R1, R2
    ADD R0, R1, #0
    TRAP x22
    LEA R0, NEW_LINE
    TRAP x22
    LEA R0, GRID_BAR_START
    TRAP x22
    ADD R1, R1, R2
    ADD R0, R1, #0
    TRAP x22
    LEA R0, NEW_LINE
    TRAP x22
    
    LEA R0, STARTING_4
    TRAP x22
    ADD R1, R1, R2
    ADD R0, R1, #0
    TRAP x22
    LEA R0, NEW_LINE
    TRAP x22
    LEA R0, GRID_BAR_START
    TRAP x22
    ADD R1, R1, R2
    ADD R0, R1, #0
    TRAP x22
    LEA R0, NEW_LINE
    TRAP x22
    
    LEA R0, STARTING_5
    TRAP x22
    ADD R1, R1, R2
    ADD R0, R1, #0
    TRAP x22
    LEA R0, NEW_LINE
    TRAP x22
    LEA R0, GRID_BAR_START
    TRAP x22
    ADD R1, R1, R2
    ADD R0, R1, #0
    TRAP x22
    LEA R0, NEW_LINE
    TRAP x22
    
    LEA R0, STARTING_6
    TRAP x22
    ADD R1, R1, R2
    ADD R0, R1, #0
    TRAP x22
    LEA R0, NEW_LINE
    TRAP x22
    LEA R0, GRID_BAR_START
    TRAP x22
    ADD R1, R1, R2
    ADD R0, R1, #0
    TRAP x22
    LEA R0, NEW_LINE
    TRAP x22
    
    LEA R0, STARTING_7
    TRAP x22
    ADD R1, R1, R2
    ADD R0, R1, #0
    TRAP x22
    LEA R0, NEW_LINE
    TRAP x22
    LEA R0, GRID_BAR_START
    TRAP x22
    ADD R1, R1, R2
    ADD R0, R1, #0
    TRAP x22
    LEA R0, NEW_LINE
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
GRID_BAR_START  .STRINGZ "  "
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
;       3. Symbol (can be I->Initial,H->Home, F->Friend or #->Hyena)
;    The list is guaranteed to: 
;               * have only one Inital and one Home gridblock
;               * have zero or more gridboxes with Hyenas/Friends
;               * be terminated by a gridblock whose next address 
;                 field is a zero
; Output: None
;   This function loads the JUNGLE from a linked list by inserting 
;   the appropriate characters in boxes (I(*),#,F,H)
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

;***********************************************************
; IS_INPUT_VALID
; Input: R0 has the move (character i,j,k,l)
; Output:  R2  zero if valid; -1 if invalid
; Notes: Validates move to make sure it is one of i,j,k,l
;        Only checks if a valid character is entered
;***********************************************************

IS_INPUT_VALID

    ST R1, IIV_SR_R1

    AND R2, R2, #0
    ADD R2, R2, #-1
    
    LD R1, CONST_i
    ADD R1, R1, R0
    BRnp IIV_not_i
    ADD R2, R2, #1
IIV_not_i

    LD R1, CONST_j
    ADD R1, R1, R0
    BRnp IIV_not_j
    ADD R2, R2, #1
IIV_not_j

    LD R1, CONST_k
    ADD R1, R1, R0
    BRnp IIV_not_k
    ADD R2, R2, #1
IIV_not_k

    LD R1, CONST_l
    ADD R1, R1, R0
    BRnp IIV_not_l
    ADD R2, R2, #1
IIV_not_l

    LD R1, IIV_SR_R1

    JMP R7
    
CONST_i   .FILL #-105
CONST_j   .FILL #-106
CONST_k   .FILL #-107
CONST_l   .FILL #-108

IIV_SR_R1   .BLKW #1

;***********************************************************
; CAN_MOVE
; This subroutine checks if a move can be made and returns 
; the new position where Simba would go to if the move is made. 
; To be able to make a move is to ensure that movement 
; does not take Simba off the grid; this can happen in any direction.
; In coding this routine you will need to translate a move to 
; coordinates (row and column). 
; Your APPLY_MOVE subroutine calls this subroutine to check 
; whether a move can be made before applying it to the GRID.
; Inputs: R0 - a move represented by 'i', 'j', 'k', or 'l'
; Outputs: R1, R2 - the new row and new col, respectively 
;              if the move is possible; 
;          if the move cannot be made (outside the GRID), 
;              R1 = -1 and R2 is untouched.
; Note: This subroutine does not check if the input (R0) is valid. 
;       You will implement this functionality in IS_INPUT_VALID. 
;       Also, this routine does not make any updates to the GRID 
;       or Simba's position, as that is the job of the APPLY_MOVE function.
;***********************************************************

CAN_MOVE      

    ST R3, CM_SR_R3
    ST R4, CM_SR_R4
    ST R5, CM_SR_R5

    LDI R3, CURRENT_ROW_PTR
    LDI R4, CURRENT_COL_PTR
    
    LD R5, CONST_i
    ADD R5, R5, R0
    BRnp CM_not_i
    ADD R5, R3, #-1
    BRn CM_OutOfBounds
    ADD R1, R3, #-1
    ADD R2, R4, #0
CM_not_i

    LD R5, CONST_j
    ADD R5, R5, R0
    BRnp CM_not_j
    ADD R5, R4, #-1
    BRn CM_OutOfBounds
    ADD R1, R3, #0
    ADD R2, R4, #-1
CM_not_j

    LD R5, CONST_k
    ADD R5, R5, R0
    BRnp CM_not_k
    ADD R5, R3, #-7
    BRz CM_OutOfBounds
    ADD R1, R3, #1
    ADD R2, R4, #0
CM_not_k

    LD R5, CONST_l
    ADD R5, R5, R0
    BRnp CM_not_l
    ADD R5, R4, #-7
    BRz CM_OutOfBounds
    ADD R1, R3, #0
    ADD R2, R4, #1
CM_not_l

BRnzp CM_InBounds
CM_OutOfBounds

AND R1, R1, #0
ADD R1, R1, #-1

CM_InBounds

    LD R3, CM_SR_R3
    LD R4, CM_SR_R4
    LD R5, CM_SR_R5

    JMP R7
    
CM_SR_R3    .BLKW #1
CM_SR_R4    .BLKW #1
CM_SR_R5    .BLKW #1

CURRENT_ROW_PTR .FILL x41DD
CURRENT_COL_PTR .FILL x41DE
HOME_ROW_PTR    .FILL x41DF
HOME_COL_PTR    .FILL x41E0

;***********************************************************
; APPLY_MOVE
; This subroutine makes the move if it can be completed. 
; It checks to see if the movement is possible by calling 
; CAN_MOVE which returns the coordinates of where the move 
; takes Simba (or -1 if movement is not possible as detailed above). 
; If the move is possible then this routine moves Simba
; symbol (*) to the new coordinates and clears any walls (|'s and -'s) 
; as necessary for the movement to take place. 
; In addition,
;   If the movement is off the grid - Output "Cannot Move" to Console
;   If the move is to a Friend's location then you increment the
;     LIFE_COUNT variable; 
;   If the move is to a Hyena's location then you decrement the
;     LIFE_COUNT variable; IF this decrement causes LIFE_COUNT
;     to become Zero then Simba's Symbol changes to X (dead)
; Input:  
;         R0 has move (i or j or k or l)
; Output: None; However yous must update the GRID and 
;               change CURRENT_ROW and CURRENT_COL 
;               if move can be successfully applied.
;               appropriate messages are output to the console 
; Notes:  Calls CAN_MOVE and GRID_ADDRESS
;***********************************************************

APPLY_MOVE

    ST R0, AM_SR_R0
    ST R1, AM_SR_R1
    ST R2, AM_SR_R2
    ST R3, AM_SR_R3
    ST R7, AM_SR_R7
    
    JSR CAN_MOVE
    
    ADD R1, R1, #0
    BRzp AM_valid_location
    LEA R0, CONST_CANNOT_MOVE
    TRAP x22
    BRnzp AM_RETURN
    AM_valid_location
    
    ST R0, AM_SR_R00
    
    JSR GRID_ADDRESS
    LDR R1, R0, #0
    
    LD R2, CONST_F
    ADD R2, R2, R1
    BRnp AM_not_friend
    LDI R2, LIFE_COUNT_PTR
    ADD R2, R2, #1
    STI R2, LIFE_COUNT_PTR
AM_not_friend

    LD R3, CONST_*

    LD R2, CONST_#
    ADD R2, R2, R1
    BRnp AM_not_hyena
    LDI R2, LIFE_COUNT_PTR
    ADD R2, R2, #-1
    BRnp AM_not_dead
    LD R3, CONST_X
AM_not_dead
    STI R2, LIFE_COUNT_PTR
AM_not_hyena

    LD R1, AM_SR_R00; R1 is the move character (i, j, k, l) | R0 is the new grid address
    
    STR R3, R0, #0
    
    LD R2, CONST_i
    ADD R2, R2, R1
    BRnp AM_not_i
    LDI R3, CURRENT_ROW_PTR
    ADD R3, R3, #-1
    STI R3, CURRENT_ROW_PTR
    LD R2, CONST_
    ADD R0, R0, #15
    ADD R0, R0, #3
    STR R2, R0, #0
    ADD R0, R0, #15
    ADD R0, R0, #3
    STR R2, R0, #0
AM_not_i

    LD R2, CONST_j
    ADD R2, R2, R1
    BRnp AM_not_j
    LDI R3, CURRENT_COL_PTR
    ADD R3, R3, #-1
    STI R3, CURRENT_COL_PTR
    LD R2, CONST_
    ADD R0, R0, #1
    STR R2, R0, #0
    ADD R0, R0, #1
    STR R2, R0, #0
AM_not_j

    LD R2, CONST_k
    ADD R2, R2, R1
    BRnp AM_not_k
    LDI R3, CURRENT_ROW_PTR
    ADD R3, R3, #1
    STI R3, CURRENT_ROW_PTR
    LD R2, CONST_
    ADD R0, R0, #-16
    ADD R0, R0, #-2
    STR R2, R0, #0
    ADD R0, R0, #-16
    ADD R0, R0, #-2
    STR R2, R0, #0
AM_not_k

    LD R2, CONST_l
    ADD R2, R2, R1
    BRnp AM_not_l
    LDI R3, CURRENT_COL_PTR
    ADD R3, R3, #1
    STI R3, CURRENT_COL_PTR
    LD R2, CONST_
    ADD R0, R0, #-1
    STR R2, R0, #0
    ADD R0, R0, #-1
    STR R2, R0, #0
AM_not_l

AM_RETURN
    
    LD R0, AM_SR_R0
    LD R1, AM_SR_R1
    LD R2, AM_SR_R2
    LD R3, AM_SR_R3
    LD R7, AM_SR_R7
    
    JMP R7
    
CONST_CANNOT_MOVE   .STRINGZ "Cannot Move"
CONST_F             .FILL #-70
CONST_#             .FILL #-35
CONST_X             .FILL x58
CONST_*             .FILL x2a
CONST_              .FILL x20

AM_SR_R0    .BLKW #1
AM_SR_R1    .BLKW #1
AM_SR_R2    .BLKW #1
AM_SR_R3    .BLKW #1
AM_SR_R7    .BLKW #1

AM_SR_R00   .BLKW #1

LIFE_COUNT_PTR  .FILL x41E1

;***********************************************************
; SIMBA_STATUS
; Checks to see if the Simba has reached Home; Dead or still
; Alive
; Input:  None
; Output: R2 is ZERO if Simba is Home; Also Output "Simba is Home"
;         R2 is +1 if Simba is Alive but not home yet
;         R2 is -1 if Simba is Dead (i.e., LIFE_COUNT =0); Also Output"Simba is Dead"
; 
;***********************************************************

SIMBA_STATUS

    ST R0, SS_SR_R0
    ST R1, SS_SR_R1
    ST R3, SS_SR_R3
    ST R4, SS_SR_R4
    
    LDI R1, CURRENT_ROW_PTR
    LDI R2, CURRENT_COL_PTR
    LDI R3, HOME_ROW_PTR
    LDI R4, HOME_COL_PTR
    
    NOT R3, R3
    ADD R3, R3, #1
    ADD R3, R3, R1
    BRnp SS_not_home
    
    NOT R4, R4
    ADD R4, R4, #1
    ADD R4, R4, R2
    BRnp SS_not_home
    
    AND R2, R2, #0
    
    LEA R0, CONST_HOME
    TRAP x22
    
    BRnzp SS_RETURN
SS_not_home

    LDI R1, LIFE_COUNT_PTR
    BRnp SS_not_dead
    
    AND R2, R2, #0
    ADD R2, R2, #-1
    
    LEA R0, CONST_DEAD
    TRAP x22
    
    BRnzp SS_RETURN
    
SS_not_dead

    AND R2, R2, #0
    ADD R2, R2, #1
    
SS_RETURN

    LD R0, SS_SR_R0
    LD R1, SS_SR_R1
    LD R3, SS_SR_R3
    LD R4, SS_SR_R4

    JMP R7
    
CONST_HOME  .STRINGZ "Simba is Home"
CONST_DEAD  .STRINGZ "Simba is Dead"

SS_SR_R0    .BLKW #1
SS_SR_R1    .BLKW #1
SS_SR_R3    .BLKW #1
SS_SR_R4    .BLKW #1
    
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
