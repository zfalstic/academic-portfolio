/* 
ARM Development Programming Assignment - EE306H
Student Name: Dawson Zhang
Student UTEID: ddz249
Task1:  Convert a given fully-parenthesized Infix expression 
        to Postfix
Task2:  Evaluate the expression for specific values of the variables
Assume: The infix expression is a string with variables that 
        are single lower-case alphabets [a-z]. operators allowed 
        are +,-,* and / 
        Variable values are stored in a value table - VTab
            an array of records where each record has two 
            attributes: symbol and value symbol is:
            one Character (8-bit) and Value
                                      a signed 32-bit number. 
*/
    .syntax unified
    .data
// These are the outcomes of your two tasks
Result:     .space 4  // This is the final evaluated result
PostFix:    .space 20 // Here goes the postfix expression
    .text
    .global main
// These are the inputs to your two tasks
InFix:  
    .string "(a+(b*((c-d)/f)))" // The InFix expression
                                        // PostFix: abcd-f/*+ for this case
  //.string "(x+y)"
  //.string "(x/y)"
  //.string "(x+x)"
    .align 2
// A Value Table of values for the variables
VTab:   
    .byte 'a'
    .align 2
    .long 2
    .byte 'b'
    .align 2
    .long -3
    .byte 'c'
    .align 2
    .long 4
    .byte 'd'
    .align 2
    .long 6
    .byte 'f'
    .align 2
    .long 2     
    .byte 0     // Expression result is -1 for this case 
    .align 2
main:   
    PUSH {LR}
    BL Task1    // Should check R0 after Task1 is done 
                // to see if it was a success or failure
    BL Task2
    PUSH {PC}

/* ++++++++++++++++++Task 1 subroutine ++++++++++ */
/*
        Algorithm: Convert Infix to Postfix

        (1) Read next character cc from Infix
            a. If cc is \0, goto Step 3
            b. If cc is '(' (left-brace), push cc on Stack
            c. If cc is an operator, push cc on Stack
            d. If cc is a variable, write it to Postfix
            e. If cc is a ')' (right-brace)
                - Pop from Stack write to Postfix
                  until a left brace (Note: do not print brace)

        (2) Goto Step 1

        (3) Write NULL (\0) to Postfix — Done

    Output: R0 has 1 for success; 0 for failure
*/

Task1:
    PUSH {R1, R2, R3, LR}

    LDR R2, =PostFix
    LDR R3, =InFix

Task1Loop2S:

    LDRB R0, [R3, #0]

    CMP R0, #0
    Beq Task1EndOfInFix

    CMP R0, #40
    Bne Task1NotLeftBrace

    PUSH {R0}

Task1NotLeftBrace:

    BL IsOp

    CMP R1, #1
    Bne Task1NotOperator

    PUSH {R0}

Task1NotOperator:

    BL IsAlpha

    CMP R1, #1
    Bne Task1NotVariable

    STRB R0, [R2, #0]
    ADDS R2, #1

Task1NotVariable:

    CMP R0, #41
    Bne Task1NotRightBrace

Task1Loop1S:

    POP {R0}

    CMP R0, #40
    Beq Task1Loop1E

    STRB R0, [R2, #0]
    ADDS R2, #1

    B Task1Loop1S

Task1Loop1E:

Task1NotRightBrace:

    ADDS R3, #1

    B Task1Loop2S

Task1EndOfInFix:

    ADDS R0, #0
    STRB R0, [R2, #0]

Task1Return:

    POP {R1, R2, R3, PC}


/*--------------End of Task1 subroutine -----------*/ 

/* ++++++++++++++++++Task 2 subroutine ++++++++++ */
/*
    Algorithm: Evaluate to a Postfix Expression

        (1) Read next char from Postfix into cc
            If cc is '\0' then goto 5

        (2) If cc is a variable, push its value on the Stack

        (3) If cc is an operator X
            - Pop 2 elements off the Stack
            - Perform operation X
            - Push result on the Stack

        (4) Goto Step 1

        (5) Pop value from Stack and write to Result
*/
Task2:
    PUSH {R0, R1, R2, R3, LR}

    LDR R3, =PostFix

Task2Loop1S:

    LDRB R0, [R3, #0]

    CMP R0, #0
    Beq Task2Loop1E

    BL IsAlpha

    CMP R1, #1
    Bne Task2NotVariable

    BL Value
    PUSH {R0}

    B Task2Loop1Next

Task2NotVariable:

    BL IsOp

    CMP R1, #1
    Bne Task2NotOperator

    POP {R2}
    POP {R1}

    CMP R0, #43
    Bne Task2NotAdd

    ADDS R1, R1, R2

Task2NotAdd:

    CMP R0, #45
    Bne Task2NotSubtract

    SUBS R1, R1, R2

Task2NotSubtract:

    CMP R0, #42
    Bne Task2NotMultiply

    MULS R1, R2

Task2NotMultiply:

    CMP R0, #47
    Bne Task2NotDivide

    BL Divide

Task2NotDivide:

    PUSH {R1}

Task2NotOperator:

Task2Loop1Next:

    ADDS R3, #1
    B Task2Loop1S

Task2Loop1E:

    POP {R0}
    LDR R1, =Result
    STR R0, [R1, #0]

    POP {R0, R1, R2, R3, PC}
/*--------------End of Task1 subroutine -----------*/    

/*  Subroutine IsAlpha: 
    Purpose: Checks if the given input is a variable
    Input: R0 has character to check
    Output: R1 has 1 if R0 is a variable: [a-z] 0 otherwise
*/

IsAlpha:

    MOVS R1, #1

    CMP R0, #97
    Bge IsAlphaInRange1

    MOVS R1, #0

IsAlphaInRange1:

    CMP R0, #122
    Ble IsAlphaInRange2

    MOVS R1, #0

IsAlphaInRange2:

    BX LR

/*  Subroutine IsOp: 
    Purpose: Checks if the given input is an operator
    Input: R0 has character to check
    Output: R1 has 1 if R0 is an operator (+,-,*,/) 0 otherwise
*/

IsOp:

    MOVS R1, #0

    CMP R0, #43
    Bne IsOpNotAdd

    MOVS R1, #1

IsOpNotAdd:

    CMP R0, #45
    Bne IsOpNotSubtract

    MOVS R1, #1

IsOpNotSubtract:

    CMP R0, #42
    Bne IsOpNotMultiply

    MOVS R1, #1

IsOpNotMultiply:

    CMP R0, #47
    Bne IsOpNotDivide

    MOVS R1, #1

IsOpNotDivide:

    BX LR

/*  Subroutine Divide
        Purpose: Divide R1 by R1
        Inputs: R1 an R2
        Output: R1 has the quotient
*/
Divide:
    push {r4,r5,lr}
    movs r5, #0             // keep quotient here
    movs r4, #0             // to flip result or not
    cmp  r1, #0
    blt  NrNeg
    cmp  r2, #0
    bgt  DoDiv
    // here means NrPos and DrNeg
    subs r2, r5, r2  // flip Dr
    movs r4, #1
    b    DoDiv
NrNeg:
    cmp  r2, #0
    blt  NrDrNeg
    // Here means NrNeg and DrPos
    subs r1, r5, r1  // flip Nr
    movs r4, #1
    b    DoDiv
NrDrNeg:
    subs r1, r5, r1  // flip Nr
    subs r2, r5, r2  // flip Dr
DoDiv:
    subs r1, r2
    bmi  DivDone
    adds r5, #1
    b    DoDiv
DivDone:
    movs r1, r5
    cmp r4, #0
    beq DivDoneDone
    movs r4, #0
    subs r1, r4, r5
DivDoneDone:
    pop {r4,r5,pc}



/*  Subroutine Value: 
    Purpose: Finds the value of a variable
    Input: R0 has the variable [a-z]
    Output: R0 has the value or 1000 if not found
*/

Value:
    PUSH {R1, R2}

    LDR R1, =VTab

ValueLoop1S:

    LDRB R2, [R1, #0]

    CMP R2, #0
    Beq ValueLoop1E

    CMP R2, R0
    Bne ValueLoop1Next

    LDR R0, [R1, #4]

    B ValueReturn

ValueLoop1Next:

    ADDS R1, #8

    B ValueLoop1S

ValueLoop1E:

    LDR R0, =1000

ValueReturn:

    POP {R1, R2}
    BX LR

.end
