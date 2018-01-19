;   0.0 Write a program that takes a double word (4 bytes) as an argument, and
;   then adds all the 4 bytes. It returns the sum as output. Note that all the
;   bytes are considered to be of unsigned value.

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
    ; Your program begins here:
    call    read_hex    ; Reads eax as hex from console.
    
    mov ebx, 0      ; Initialize ebx to 0
    
    ; 1st 8 bits
    movzx ecx, al
    add ebx, ecx
    
    ; 2nd 8 bits
    movzx ecx, ah
    add ebx, ecx
    
    ; 3rd 8 bits
    shr eax, 16     ; Shift the high 16 bits into the low 16 bits of eax
    movzx ecx, al
    add ebx, ecx
    
    ; 4th 8 bits
    movzx ecx, ah
    add ebx, ecx

    ; print sum
    mov eax, ebx
    call print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'

