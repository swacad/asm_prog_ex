; Basic Assembly
; ==============
; 
; Bitwise operations - Practical bit games
; ----------------------------------------
;
    ; 0.1   Write a program that takes three numbers x,y,z as input, and returns:
          ; - 0 if (x+y+z) is even.
          ; - 1 if (x+y+z) is odd.

          ; (Note that here + means arithmetic addition).
          ; Do it without actually adding the numbers.
; HINT: Use the XOR instruction.

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:

    call    read_hex
    mov ecx, eax
    
    call read_hex
    mov ebx, eax
    
    call read_hex
    
    ;call    print_eax
    ;call    print_eax_binary
    
    xor eax, ebx
    xor eax, ecx
    
    and eax, 1
    jz even
    jmp exit

even:
    xor eax, eax

exit: ; Print EAX and exit the process:
    call print_eax
	push	0
	call	[ExitProcess]

include 'training.inc'
