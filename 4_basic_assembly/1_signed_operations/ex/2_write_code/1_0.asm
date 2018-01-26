; 1. Finding the bit flip of a number.
   ; Create a program that takes the number x as input, flips all its bits and
   ; returns the result. Use the NEG instruction to do that, together with other
   ; instructions that we have learned.

   ; HINT: Remind yourself how the two's complement negation work, and try to use
; it to your advantage.

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
    ; Your program begins here:
    call    read_hex    ; Reads eax as hex from console.
    neg eax
    sub eax, 1
    call    print_eax   ; Prints eax as hex back to console.

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'

