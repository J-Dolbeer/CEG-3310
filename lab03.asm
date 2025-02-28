.ORIG x3000
; = = = = = = = = = = = = = = = = =

; MAIN CODE HERE
MAIN_LOOP
JSR GETNUM
ST R0, NUM_1

JSR GETOP
ST R0, OP

JSR GETNUM
ST R0, NUM_2

JSR CALC
ST R0, ANSWER

JSR DISPLAY
BRnzp MAIN_LOOP

HALT
; - - - - - - - - - - - - - - - - -

; MAIN VARS

; = = = = = = = = = = = = = = = = =
NUM_1 .FILL #0
OP .FILL #0
NUM_2 .FILL #0
ANSWER .FILL #0
; = = = = = = = = = = = = = = = = =
DISPLAY

; DISPLAY CODE HERE
ST R7, SAVE_R7_DISPLAY



LD R7, SAVE_R7_DISPLAY
RET
; - - - - - - - - - - - - - - - - -
; DISPLAY VARS
SAVE_R7_DISPLAY .FILL #0
; = = = = = = = = = = = = = = = = =

; = = = = = = = = = = = = = = = = =
GETNUM

; GETNUM CODE HERE
ST R7, SAVE_R7_GETNUM

; PROMPT FOR INPUT
LD R2, ASCII_OFFSET
LEA R0, INPUT_NUM_PROMPT
PUTS

;GET FIRST DIGIT
GETC
OUT
ADD R0, R0, R2
AND R1, R1, #0
ADD R1, R1, R0

;MULTIPLY BY 10
AND R3, R3, #0
LD R3, COUNTER

MULT_LOOP
ADD R1, R1, R0
ADD R3, R3, #1
BRnp MULT_LOOP

;GET SECOND DIGIT
GETC
OUT
ADD R0, R0, R2

;CONVERT TO DECIMAL
ADD R0, R0, R1

LD R7, SAVE_R7_GETNUM
RET
; - - - - - - - - - - - - - - - - -
; GETNUM VARS
SAVE_R7_GETNUM .FILL #0
INPUT_NUM_PROMPT .STRINGZ "\nEnter number (00-99):"
ASCII_OFFSET .FILL #-48
COUNTER .FILL #-9
; = = = = = = = = = = = = = = = = =

; = = = = = = = = = = = = = = = = =
GETOP

; GETOP CODE HERE
ST R7, SAVE_R7_GETOP

; PROMPT FOR INPUT
LEA R0, INPUT_OP_PROMPT
PUTS

;GET INPUT
GETC
OUT

LD R7, SAVE_R7_GETOP
RET
; - - - - - - - - - - - - - - - - -
; GETOP VARS
SAVE_R7_GETOP .FILL #0
INPUT_OP_PROMPT .STRINGZ "\nEnter an operation (+, -, *):"
; = = = = = = = = = = = = = = = = =

; = = = = = = = = = = = = = = = = =
CALC

; CALC CODE HERE
ST R7, SAVE_R7_CALC

LD R0, NUM_1
LD R1, OP
LD R2, NUM_2
LD R3, OP_CHECK

ADD R3, R1, R3
BRz ADDITION
BRp SUBTRACTION
BRn MULTIPLICATION


ADDITION
ADD R0, R0, R2

SUBTRACTION
NOT R2, R2
ADD R2, R2, #1
ADD R0, R0, R2

MULTIPLICATION


LD R7, SAVE_R7_CALC
RET
; - - - - - - - - - - - - - - - - -
; CALC VARS
SAVE_R7_CALC .FILL #0
OP_CHECK .FILL #-43
; = = = = = = = = = = = = = = = = =

.END