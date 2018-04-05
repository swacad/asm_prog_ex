; Basic Assembly
; ==============
; 
; Bitwise operations - Practical bit games
; ----------------------------------------
;
; Hamming
; @@@@@@@
;
; 0.    Assemble and run this program.
; 
; 1.    How many inputs does this program expect?
;
; 2.    Try to give different inputs to this program, and check the results.
;
; 3.    Read the program's code below, and try to understand what does it do. Try
;       to describe it as simply as you can.
;       Add comments if needed.
;       
; 4.    What is the largest output that you have managed to get from the program?
;       What is the largest possible output? Can you find a way to reach it?
;

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:

    call    read_hex
    mov     edx,eax
    call    read_hex
    xor     eax,edx

    xor     ebx,ebx     ; Zero ebx.
    mov     ecx,32d

add_bit:
    mov     esi,eax
    and     esi, 1       ; leave low order bit in esi
    add     ebx,esi     ; Increment ebx with esi (may be 0)
    ror     eax, 1      ; rotate eax by 1 to right
    loop    add_bit     ; loop back to add_bit (32 times)

    mov     eax,ebx     ; Copy result of counting all 1 bits in eax to eax.
    call    print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]


include 'training.inc'
