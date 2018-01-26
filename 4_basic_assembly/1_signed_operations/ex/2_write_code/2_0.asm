; 2. Find out a way to implement NEG using the SUB instruction (And some other
   ; instructions that we have learned). Write a small piece of code which
; demonstrates your conclusion.

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
    ; Your program begins here:
    call    read_hex    ; Reads eax as hex from console.
    mov ebx, -1
    imul ebx
    
    call    print_eax   ; Prints eax as hex back to console.

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'

