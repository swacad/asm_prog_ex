; Basic Assembly
; ==============
; 
; Bitwise operations - Practical bit games
; ----------------------------------------
;
; Endiana Jones
; @@@@@@@@@@@@@
;
; 0.    Assemble and run this program.
; 
; 1.    How many inputs does this program expect?
;
; 2.    Try to give different inputs to this program, and check the results.
;       Particularly, check the following input: 11223344.
;
; 3.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;   Answer: Reverses bytes in EAX
;       
; 4.    Pick some random inputs and verify your predictions about what this
;       program does.
;

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executabled

start:
    call    read_hex
    mov     ecx, 4  ; ECX == 4
pass_byte:			; Loop 4 times
    shl     ebx,8   ; <- Left shift with 0 fill EBX by 8 => lower 8 bits (bl) have all zeros
    mov     bl,al   ; Move lower 8 bits of EAX to lower 8 bits of EBX
    shr     eax,8   ; Right shift EAX by 8
    loop    pass_byte

    mov     eax,ebx 	; Copy EBX into EAX.
    call    print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]


include 'training.inc'
