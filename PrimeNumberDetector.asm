; PrimeNumberDetector.asm
; Jadon Scholes, uvid: 10734919
; PURPOSE: Read a number from the keyboard, determine if it is a prime number
; and print the result to the console screen
; DEPENDENCIES:  getn, printn
;
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
		BRN INPUTERROR ; If the input returns -1 from GETNUM, outputs an error
		BRZ INPUTERROR ; If the input returns 0 from GETNUM, outputs an error
	ADD R3, R3, R0
	LD R1, PRINTNUM ; Print the number to the console screen
	JSRR R1
; 
; Check if n is <= 4
	ADD R5, R3, #-4
		BRN ISPRIMENUM ; If the number is less than four, it is a prime num.
		BRZP SETINCREMENTNUM ; If the number is 4 or greater, move on.
;
; SETINCREMENTNUM sets the i value. This is the number that we will divide by
; that increments.
SETINCREMENTNUM
	ADD R4, R3, #2 ; Sets i = 2
;
LOOP
	AND R0, R0, #0
	AND R1, R1, #0
	ADD R0, R3, #0
	ADD R1, R4, #0
	LD R2, DIVIDE
	JSRR R2
	ADD R1, R1, #0 ; Check if % == 0
		BRz ISPRIMENUM
		ADD R4, R4, #1 ; i++
		ADD R4, R2, #-1 ; check if i >= n 
			BRz NOTPRIMENUM
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
	.FILL x5200
;
.END
