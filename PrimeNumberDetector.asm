; PrimeNumberDetector.asm
; Jadon Scholes, uvid: 10734919
; PURPOSE: Read a number from the keyboard, determine if it is a prime number
; and print the result to the console screen
; DEPENDENCIES:  getn, printn, divide
;
;-------------------------------------------------------------------------------
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
	ADD R1, R1, #1 ; Check result of GETNUM
		BRNZ INPUTERROR ; If input returns -2 or -1 from GETNUM, outputs error
	ADD R3, R3, R0 ; Copy successful GETNUM result in R0
	LD R1, PRINTNUM ; Print the number to the console screen
	JSRR R1
; 
; Check if n is <= 2
	ADD R5, R3, #-2
		BRZ ISPRIMENUM ; If n is 2 it is prime. 
		BRN NOTPRIMENUM ; If the n is 1 or 0 it is not prime.
		BRP SETDIVISOR ; If the number is greater than 2, move on.
;
; SETDIVISOR sets the i value to 2. This is the number that we will divide by
; that increments.
SETDIVISOR
	ADD R4, R4, #2
;
LOOP
; Clear the registers
	AND R0, R0, #0
	AND R1, R1, #0
	AND R5, R5, #0
;
	ADD R0, R3, #0 ; Copy the input number (dividend) to R0
	ADD R1, R4, #0 ; Copy i (divisor) to R1
;
	LD R2, DIVIDE ; R0 is the result, R1 is the remainder
	JSRR R2
	ADD R1, R1, #0 ; Check if the result of % == 0
		BRZ NOTPRIMENUM
		ADD R4, R4, #1 ; Update divisor(i)
		NOT R5, R4 ; Negate the divisor and store it in r(5) 
		ADD R5, R5, R0 ; check if divisor(i) is less than n  
			BRN ISPRIMENUM ; If the i > n, then it is prime 
			BR LOOP ; Else, loop and divide again
;
;----------------------------------------------------------------
;
; Result Steps
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
; Output Messages
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
;-------------------------------------------------------------------
;
; Fill for subroutines
;
PRINTNUM
	.FILL X5000
GETNUM
	.FILL x4300
DIVIDE
	.FILL x5100
;
;-------------------------------------------------------------------- 
; Finished
.END
