.ORIG x3000

LD R0, ArrayPtr
LD R2, Converter
AND R3, R3, #0

Loop1S
LDR R1, R0, #0
BRz Loop1E

ADD R1, R1, R2

ADD R3, R3, R3
ADD R3, R3, R3
ADD R3, R3, R3

ADD R3, R3, R1

ADD R0, R0, #1
BRnzp Loop1S
Loop1E

STI R3, Result

HALT
ArrayPtr    .FILL x4000
Converter   .FILL #-48
Result      .FILL x5000
.END

.ORIG x4000
.FILL x31
.FILL x37
.FILL x32
.FILL x00
.END

.ORIG x5000
.BLKW #1
.END