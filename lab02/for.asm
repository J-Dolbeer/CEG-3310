.ORIG X3000

AND R0, R0, #0
ST R0, VAR_I

START_LOOP
LD R0, VAR_I
LD R1, MAX_ITER
NOT R1, R1
ADD R1, R1, #1
ADD R0, R0, R1
BRzp END_LOOP

ADD R3, R3, #5

LD R0, VAR_I
ADD R0, R0, #1
ST R0, VAR_I
BRnzp START_LOOP
END_LOOP

STI R3, RESULT

HALT

VAR_I .FILL #0
MAX_ITER .FILL #10
RESULT .FILL X8001

.END