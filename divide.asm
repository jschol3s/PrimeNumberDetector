; divide.asm
; a subroutine that implements integer division and modulus
; PARAMETERS:
; R0 - dividend
; R1 - divisor
; RETURN VALUES
; R0 - quotient
; R1 - modulus (remainder)
; LIMITATIONS:
; Only works with positive numbers
; ERROR CHECKING:
; If either dividend or divisor is negative, or divisor is zero, returns -1

.ORIG x5100
	BR divide
SaveR2
	.fill #0
SaveR6
	.FILL #0
SaveR7
	.FILL #0
ErrorCode
	.fill #-1
divide
	; save r6 and return address
	ST r2, SaveR2
	ST r6, SaveR6
	ST R7, SaveR7
	ADD R2, r0, #0		; copy dividend to R2
	brn error				; check dividend < 0
	AND R0, r0, #0		; clear r0 to initialize quotient
	ADD R6 r1, #0		; copy divisor to r6
	brnz error			; check divisor <= 0
	NOT r6, r6
	ADD R6, R6, #1		; take 2's complement
	add r1, r2, #0		; copy dividend to r1
again
	add r1, r1, r6		; subtract divisor
	brn done			; if negative, stop
	add r0, r0, #1		; count successful subtractions
	br again			; subtract again
error
	LD r0, ErrorCode	; error code
	br return
done
	NOT r6, r6
	add r6, r6, #1		; take 2's complement
	add r1, r1, r6		; normalize remainder
return
	; retrieve r6 and return address
	LD r2, SaveR2
	ld r6, SaveR6
	ld r7, SaveR7
	RET
.end
