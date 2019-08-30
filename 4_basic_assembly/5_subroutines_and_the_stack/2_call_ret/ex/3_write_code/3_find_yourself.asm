; 2.  Find yourself
    
    ; Write a program that finds the current value of EIP and prints it to the
    ; console.

    ; HINT: Use CALL.


format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.data' data readable writeable


; ===============================================
section '.text' code readable executable

start:
    call print_eip

    
exit: ; Exit the process:
	push	0
	call	[ExitProcess]

print_eip:
    pop eax
    call print_eax
    push eax
    ret
    

include 'training.inc'
