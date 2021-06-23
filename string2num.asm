; string2num.asm
; a subroutine to convert a string of decimal digits to a binary number
; Parameters: r0-pointer to string, r1-length of string
; Return values: r0 - binary value, r1 - error code
; Error handling
; has a limit of unsigned values in 16 bits
; does not handle negative numbers
; will return -1 if value would exceed 16 bits
; returns -2 if there are invalid characters
; DEPENDENCIES: multiply

	.ORIG x4200
	BR string2num
SaveR1	.fill #0
SaveR2	.FILL #0
SaveR3	.FILL #0
SaveR4	.FILL #0
SaveR5  .fill #0
SaveR7	.FILL #0
ToValue	.FILL x-30
Multiplier	.FILL #10
ValueErrorCode	.FILL #-1
CharacterErrorCode .FILL #-2
multiply .fill x4100
string2num
	; save registers
	ST R2, SaveR2
	ST R3, SaveR3
	ST R4, SaveR4
	ST R5, SaveR5
	ST R7, SaveR7

	AND R3, R3, #0			; clear final sum
  ADD R2, R1, #-5
	BRP ValueError			; too many characters
	ADD R2, R1, #0			; transfer count to R2
	BRZ ValueError 			; no characters entered
	ADD R5, R0, #0			; move pointer to R5
getChar
	LDR R0, R5, #0			; get character
	BRZ done 						; end of string
	LD R4, ToValue			; value to convert character to value
	ADD R0, R0, R4			; convert to value
	BRN CharacterError
	ADD R4, R0, #-9
	BRP CharacterError
	ADD R3, R3, R0			; add value of digit
	add r2, r2, #-1			;  decrement count
	brz done
	add r0, r3, #0			; copy multiplicand to R0
	LD R1, Multiplier			; multiply by ten
	ld R4, multiply
	jsrr r4
	add r3, r0, #0			;  product copied to r3
	add r5, r5, #1			;  increment pointer
	BR getChar					; get another character
ValueError
	LD R1, ValueErrorCode	; error code
	BR exit
CharacterError
	LD R1, CharacterErrorCode
	br exit
done
  and r1, r1, #0			; zero error code
exit
  add r0, r3, #0			; return value in r0
	; restore registers
	LD R2, SaveR2
	LD R3, SaveR3
	LD r4, SaveR4
	LD r5, SaveR5
	LD R7, SaveR7
	RET
.end
