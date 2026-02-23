// ****************** ECE319K_Lab1.s ***************
// Your solution to Lab 1 in assembly code
// Author: Dawson Zhang
// Last Modified: January 24
// Spring 2026
        .data
        .align 2
// Declare global variables here if needed
// with the .space assembly directive

        .text
        .thumb
        .align 2
        .global EID
EID:    .string "DDZ249" // replace ZZZ123 with your EID here

        .global Phase
        .align 2
Phase:  .long 10 
// Phase= 0 will display your objective and some of the test cases, 
// Phase= 1 to 5 will run one test case (the ones you have been given)
// Phase= 6 to 7 will run one test case (the inputs you have not been given)
// Phase=10 will run the grader (all cases 1 to 7)
        .global Lab1
// Input: R0 points to the list
// Return: R0 as specified in Lab 1 assignment and terminal window
// According to AAPCS, you must save/restore R4-R7
// If your function calls another function, you must save/restore LR
Lab1:   PUSH {R1-R7,LR}
        LDR R1, =-1

NextList:
        LDR R2, [R0] // R2 is address to EID string (in array)
        CMP R2, #0 
        BEQ ListEnd

        LDR R3, =EID // R3 is address to EID string (my own)

NextCharacter:
        LDRB R4, [R2]
        LDRB R5, [R3]
        CMP R4, R5
        BNE DifferentCharacter

        CMP R4, #0 // Both at terminating character
        BNE NotTerminating

        LDR R1, [R0, #4]

        B ListEnd

NotTerminating:
        ADDS R2, R2, #1
        ADDS R3, R3, #1

        B NextCharacter

DifferentCharacter:

        ADDS R0, R0, #8
        B NextList

ListEnd:
        MOVS R0, R1
        POP  {R1-R7,PC} // return


        .align 2
        .global myClass
myClass: .long pAB123  // pointer to EID
         .long 95      // Score
         .long pXYZ1   // pointer to EID
         .long 96      // Score
         .long pAB5549 // pointer to EID
         .long 94      // Score
         .long 0       // null pointer means end of list
         .long 0
pAB123:  .string "AB123"
pXYZ1:   .string "XYZ1"
pAB5549: .string "AB5549"
        .end
