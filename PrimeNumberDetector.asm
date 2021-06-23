; PrimeNumberDetector.asm
; Jadon Scholes, uvid: 10734919
; PURPOSE: Read a number from the keyboard, determine if it is a prime number
; and print the result to the console screen
; DEPENDENCIES:  getn, printn
;
	.ORIG x3000
	BR _start
Prompt
	.STRINGZ "Enter a number> "
ERROR
	.stringz "Overflow detected\n"
printn
	.FILL X5000
getn
	.FILL x4300

_start
	LEA R0, Prompt
	PUTS
	LD R1, getn
	JSRR R1

	add r0, r0, r0
	LD R1, printn
	JSRR R1
	add r0, r0, #0
	brzp end
	lea r0, ERROR
	PUTS
end	br _start
.end
