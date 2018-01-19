;   0.1 Write a program that does the same, except that it multiplies the four
;   bytes. (All the bytes are considered to be unsigned).

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
    ; Your program begins here:
    call    read_hex    ; Reads eax as hex from console.
    
    mov ecx, eax
    mov ebx, 0
    movzx eax, cl
    call print_eax
    
    ; 1st 8 bits
    ;mul cl
    ;call print_eax
    
    ; 2nd 8 bits
    shr ecx, 8
    mul cl
    call print_eax
    
    ; 3rd 8 bits
    shr ecx, 8
    movzx ebx, cl
    mul ebx
    call print_eax
    
    ; 4th 8 bits
    shr ecx, 8
    movzx ebx, cl
    mul ebx
    
    call print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'

