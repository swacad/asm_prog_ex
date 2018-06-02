; Basic Assembly
; ==============
; 
; Memory
; ------
;
; Template
; @@@@@@@@
;

format PE console
entry start

include 'win32a.inc' 

; This is the text section:
; ===============================================
section '.text' code readable executable

start:
    ; Program begins here.
    mov     esi,start
    mov ebx, 0
    
print_byte:
    movzx   eax, byte [esi]                 ; Move byte in address to EAX
    add ebx, eax
    call    print_eax
    inc     esi
    cmp     esi,end_prog
    jnz     print_byte

mod_hundred:
    and ebx, 255h       ; Takes EBX modulo 0x100
    mov eax, ebx
    call print_eax
    
exit:
    ; Exit the process:
	push	0
	call	[ExitProcess]

; A label that marks the end of our code.
end_prog:



include 'training.inc'
