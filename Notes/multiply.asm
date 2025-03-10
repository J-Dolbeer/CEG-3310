.ORIG x3000
; = = = = = = = = = = = = = = = = =
; MAIN CODE HERE
LD R0, VAR_A
LD R1, VAR_B

JSR MULT

ST R0, PRODUCT

HALT
; - - - - - - - - - - - - - - - - -
; MAIN VARS
VAR_A .FILL #4
VAR_B .FILL #7
PRODUCT .FILL #0
; = = = = = = = = = = = = = = = = =

; = = = = = = = = = = = = = = = = =
MULT
; SAVE RETURN ADDRESS
ST R7, SAVE_R7_MULT

; SAVING ARGUMENTS INTO PARAMETERS
ST R0, FACTOR_1
ST R1, FACTOR_2

; INT MULT_RESULT = 0
AND R0, R0, #0
ST R0, MULT_RESULT

;INT i=0
ST R0, VAR_I_MULT

START_MULT_LOOP
; i < FACTOR_2
LD R0, VAR_I_MULT
LD R1, FACTOR_2
NOT R1, R1
ADD R1, R1, #1
ADD R0, R0, R1
BRzp END_MULT_LOOP

; MULT_RESULT += FACTOR_1
LD R0, MULT_RESULT
LD R1, FACTOR_1
ADD R0, R0, R1
ST R0, MULT_RESULT

; i++
LD R0, VAR_I_MULT
ADD R0, R0, #1
ST R0, VAR_I_MULT

BRnzp START_MULT_LOOP
END_MULT_LOOP

; LOAD RETURN RESULT
LD R0, MULT_RESULT

; RESTORE RETURN ADDRESS
LD R7, SAVE_R7_MULT
RET
; - - - - - - - - - - - - - - - - -
; MULT VARS
SAVE_R7_MULT .FILL #0
FACTOR_1 .FILL #0
FACTOR_2 .FILL #0
MULT_RESULT .FILL #0
VAR_I_MULT .FILL #0
; = = = = = = = = = = = = = = = = =
.END