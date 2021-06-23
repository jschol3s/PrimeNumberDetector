; read.asm
; subroutine to read string from keyboard
; uses GETC; stops on newline, substitutes 0 for newline
; Parameters:  r0-points to buffer, r1-size of buffer
; Return value:  r0-number of characters read
; Limitations:  does not print prompt

.orig x4000
br start
saveR1 .fill #0
saveR2 .fill #0
saveR3 .fill #0
saveR4 .fill #0
saveR7 .fill #0
start
    st r1, saveR1
    st r2, saveR2
    st r3, saveR3
    st r4, saveR4
    st r7, saveR7
    add r2, r0, #0      ; save pointer to r2
    and r4, r4, #0      ; clear counter
again
    GETC
    OUT
		str r0, r2, #0      ; store character
    add r3, r0, #-10    ; check for newline
    brz done
    add r4, r4, #1      ; increment count
    add r2, r2, #1      ; increment pointer
    add r1, r1, #-1     ; check for end of buffer
    brp again
		and r0, r0, #0
		add r0, r0, #10
		out

done
    and r3, r3, #0
    str r3, r2, #0      ; store 0 as final character
    add r0, r4, #0      ; return count
    ld r1, saveR1
    ld r2, saveR2
    ld r3, saveR3
    ld r4, saveR4
    ld r7, saveR7
    ret
.end
