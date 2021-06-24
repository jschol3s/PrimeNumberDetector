; PrimeNumberDetector.asm
; Jadon Scholes, uvid: 10734919
; PURPOSE: Read a number from the keyboard, determine if it is a prime number
; and print the result to the console screen
; DEPENDENCIES:  getn, printn
;
; TODO: Not working with double digit numbers as input.
; TODO: Always returning that a number is not prime. Something is wrong with
; the modulus comparison.
; Start Program
.ORIG x3000
; Clear the registers
	AND R0, R0, #0
	AND R1, R1, #0
	AND R2, R2, #0
	AND R3, R3, #0
	AND R4, R4, #0
	AND R5, R5, #0
;
; Welcome
	LEA R0, WELCOME
	PUTS
;
; Get Input
GETINPUT
	LEA R0, PROMPT
	PUTS
	LD R1, GETNUM
	JSRR R1
	ADD R1, R1, #1
		BRNZ INPUTERROR ; If input returns -1 or 0 from GETNUM, outputs error
	ADD R3, R3, R0
	LD R1, PRINTNUM ; Print the number to the console screen
	JSRR R1
; 
; Check if n is <= 1
	ADD R5, R3, #-1
		BRNZ ISPRIMENUM ; If the number is one it is not prime.
		BRP SETDIVISOR ; If the number is greater than one, move on.
;
; SETDIVISOR sets the i value. This is the number that we will divide by
; that increments.
SETDIVISOR
	ADD R4, R4, #2
;
LOOP
	AND R0, R0, #0
	AND R1, R1, #0
	ADD R0, R3, #0
	ADD R1, R4, #0
	LD R2, DIVIDE ; R0 is the result, R1 is the remainder
	JSRR R2
	ADD R1, R1, #0 ; Check if % == 0
		BRZ NOTPRIMENUM
		ADD R4, R4, #1 ; Update divisor(i)
		ADD R4, R4, R0 ; check if divisor(i) is equal to n  
			BRZ ISPRIMENUM
			BR LOOP
;
;----------------------------------------------------------------
;
INPUTERROR
	LEA R0, ERRORMESSAGE
	PUTS
	BR GETINPUT
;
ISPRIMENUM
	LEA R0, ISPRIMEMESSAGE
	PUTS
	BR DONE
;
NOTPRIMENUM
	LEA R0, NOTPRIMEMESSAGE
	PUTS
	BR DONE
;
DONE
	LEA R0, GOODBYE
	PUTS
	HALT
;
;------------------------------------------------------------------- 
;
WELCOME
	.STRINGZ	"Welcome to the Prime Number Detector!\n\n"
PROMPT
	.STRINGZ "Enter a number: "
ISPRIMEMESSAGE
	.STRINGZ	"Is a prime number.\n"
NOTPRIMEMESSAGE
	.STRINGZ	"Is not a prime number.\n"
GOODBYE
	.STRINGZ	"Thank you for using the Prime Number Detector."
ERRORMESSAGE
	.STRINGZ	"There was an error with your input. Please try again:\n"
;
PRINTNUM
	.FILL X5000
GETNUM
	.FILL x4300
DIVIDE
	.FILL x5100
;
.END
