; Basic Assembly
; ==============
; 
; Bitwise operations - Practical bit games
; ----------------------------------------
;
; 0.  Even or Odd:

    ; 0.0   Write a program that takes a number x as input, and returns:
          ; - 0 if x is even.
          ; - 1 if x is odd. 

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:

    call    read_hex
    call    print_eax
    call    print_eax_binary
    
    ; 0.0
    mov ebx, eax
    and ebx, 1
    jz even
    mov eax, ebx
    jmp exit

even:
    xor eax, eax

exit: ; Print EAX and exit the process:
    call print_eax
	push	0
	call	[ExitProcess]

include 'training.inc'
