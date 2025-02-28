.ORIG x3000
; Start by printing prompt to user
START
LEA R0, INPUT_PROMPT
PUTS

; Get the address of PASSWORD
LEA R2, PASSWORD
AND R4, R4, #0

; Count the characters in PASSWORD until we hit 0 (null terminator)
COUNT_LOOP
LDR R0, R2, #0
BRz FINISH_COUNT
ADD R4, R4, #1
ADD R2, R2, #1
BRnzp COUNT_LOOP


FINISH_COUNT
LEA R2, PASSWORD
ST R4, PASSWORD_COUNT
AND R3, R3, #0

; Get each character
GET_CHARACTER_LOOP
GETC
OUT
ADD R1, R0, #-10 	; Check if enter was typed (0x0A)
BRz ENTER_DETECTED

; Compare the character to the character in the string
LDR R1, R2, #0		; Load the next character from the PASSWORD string
NOT R1, R1
ADD R1, R1, #1		; Make it negative

ADD R2, R2, #1		; Make R2 point to the next character in the PASSWORD string

; Subtract 1 from our string length to make sure it is 0 at the end
ADD R4, R4, #-1		; Track how many characters the user types
ADD R1, R0, R1		; Add it to the character we got from the user
BRz CORRECT_DETECTED

; Set R3 to 1 if anything was incorrect
AND R3, R3, #0
ADD R3, R3, #1		; Set R3 to 1 if we detected an incorrect character

; Loop again
CORRECT_DETECTED
BRnzp GET_CHARACTER_LOOP

ENTER_DETECTED
ADD R4, R4, #0			; Check if R4 is zero (password length - characters typed count)
BRnp LOGIN_UNSUCCESSFUL
ADD R3, R3, #0			; Check if R3 is zero (no incorrect values typed)
BRz LOGIN_SUCCESSFULL
LOGIN_UNSUCCESSFUL
LEA R0, INCORRECT_PROMPT
PUTS
BRnzp START

; If login was successful print a nice message and stop looping
LOGIN_SUCCESSFULL
LEA R0, CORRECT_PROMPT
PUTS

HALT

PASSWORD .STRINGZ "ABCD1234"
PASSWORD_COUNT .FILL #0
INPUT_PROMPT .STRINGZ "Please enter your password: "
INCORRECT_PROMPT .STRINGz "Login Unsuccessful: Incorrect Password\n"
CORRECT_PROMPT .STRINGZ "Login Successful\n"

.END